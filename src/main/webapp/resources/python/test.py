import os
import cv2
import timm
import torch
import numpy as np
import albumentations as A
from torch.utils.data import Dataset, DataLoader

model_name = "swsl_resnext50_32x4d"
batch_size = 96


class TestDataset(Dataset):
    def __init__(self, file_lists, transforms=None):
        self.file_lists = file_lists.copy()
        self.transforms = transforms

    def __getitem__(self, idx):
        img = cv2.imread(self.file_lists[idx], cv2.IMREAD_COLOR)
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

        if self.transforms:
            img = self.transforms(image=img)["image"]

        img = img.transpose(2, 0, 1)

        img = torch.tensor(img, dtype=torch.float)
        return img

    def __len__(self):
        return len(self.file_lists)


device = torch.device("cpu")  # cpu
# device = torch.device("cuda")  # gpu

class_path = './dataset/'
class_list = os.listdir(class_path)
class_encoder = {}
for i in class_list:
    class_encoder.update({class_list[class_list.index(i)]: class_list.index(i)})

class_decoder = {v: k for k, v in class_encoder.items()}


test_transforms_ = A.Compose([
    A.Normalize()
])

test_files = os.listdir("./test/")
test_files = sorted(test_files)
test_files = list(map(lambda x: "/".join(["./test", x]), test_files))

test_dataset = TestDataset(file_lists=test_files, transforms=test_transforms_)
test_loader = DataLoader(test_dataset, batch_size=batch_size, shuffle=False)

answer_logits = []

model = timm.create_model(model_name, pretrained=True, num_classes=len(class_list)).to(device)
model.load_state_dict(torch.load("./model.pth", map_location="cpu"))
model.eval()

with torch.no_grad():
    for iter_idx, test_imgs in enumerate(test_loader, 1):
        test_imgs = test_imgs.to(device)
        test_pred = model(test_imgs)

        print(class_decoder[np.argmax(test_pred.cpu(), axis=-1).item()])
