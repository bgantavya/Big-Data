import os
import img2pdf

input_folder = "./output"  
output_folder = "./pdfs"   
os.makedirs(output_folder, exist_ok=True)

for filename in os.listdir(input_folder):
    if filename.lower().endswith(".png"):
        
        png_path = os.path.join(input_folder, filename)
        pdf_filename = filename[:-4] + ".pdf" # Swap .png for .pdf
        pdf_path = os.path.join(output_folder, pdf_filename)

        print(f"Converting: {filename}...")
        with open(pdf_path, "wb") as f:
            f.write(img2pdf.convert(png_path))

print("All PNGs have been converted to individual PDFs!")
