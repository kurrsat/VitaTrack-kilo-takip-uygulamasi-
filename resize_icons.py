
import os
from PIL import Image

# Source icon
source_path = r"assets/icon/app_icon.png"

# Android res folder
res_folder = r"android/app/src/main/res"

# Map folders to sizes (px)
sizes = {
    "mipmap-mdpi": 48,
    "mipmap-hdpi": 72,
    "mipmap-xhdpi": 96,
    "mipmap-xxhdpi": 144,
    "mipmap-xxxhdpi": 192,
}

def generate_icons():
    if not os.path.exists(source_path):
        print(f"Error: Source file {source_path} not found.")
        return

    try:
        img = Image.open(source_path)
        print(f"Opened source image: {source_path} ({img.size})")

        for folder, size in sizes.items():
            folder_path = os.path.join(res_folder, folder)
            if not os.path.exists(folder_path):
                os.makedirs(folder_path, exist_ok=True)
                print(f"Created directory: {folder_path}")

            # Resize
            resized_img = img.resize((size, size), Image.Resampling.LANCZOS)
            
            # Save as ic_launcher.png
            dest_path = os.path.join(folder_path, "ic_launcher.png")
            resized_img.save(dest_path)
            print(f"Saved {dest_path} ({size}x{size})")
            
            # Save as ic_launcher_round.png (using same square icon for now to prevent build errors if referenced)
            # Ideally this should be masked circular, but square is better than missing file
            dest_round_path = os.path.join(folder_path, "ic_launcher_round.png")
            resized_img.save(dest_round_path)

        print("Success! All icons generated.")

    except Exception as e:
        print(f"Error processing image: {e}")

if __name__ == "__main__":
    generate_icons()
