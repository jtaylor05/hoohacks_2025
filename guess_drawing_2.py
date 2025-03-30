import os
import ollama
import time
from PIL import Image
import numpy as np

def generate_caption(img_path, model_name="llava"):
    messages = [
        {
            "role": "system",
            "content": "You are a helpful assistant."
        },
        {
            "role": "user",
            "content": f"Please use two words to describe what the lines in this image most closely resemble: {img_path}"
        }
    ]

    response = ollama.chat(model=model_name, messages=messages)
    
    caption = response["message"]["content"]
    return caption

def write_caption_to_file(caption, file_path="hoohacks_2025/render_project/captions/captions.txt"):
    with open(file_path, "a") as f:  
        f.write(caption + "\n")

while True:
    directory_path = '~/Library/Application Support/Godot/app_userdata/HackathonProject/screenshot.png'

    directory_path = os.path.expanduser(directory_path)

    if os.path.isfile(directory_path):
        img_file = os.path.basename(directory_path)
        img_path = directory_path
        if img_file.endswith(('.jpg', '.jpeg', '.png')):  
            caption = generate_caption(img_path, model_name="llava")
            write_caption_to_file(caption)
    
    time.sleep(10)
