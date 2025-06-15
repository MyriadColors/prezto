import os
from pypdf import PdfReader

def extract_pdf_text(pdf_path, output_path):
    """
    Extracts the text content from a PDF file and saves it to a .txt file.

    Parameters:
    pdf_path (str): Path to the input PDF file.
    output_path (str): Path to the output .txt file.
    """
    with open(pdf_path, 'rb') as pdf_file:
        pdf_reader = PdfReader(pdf_file)

        # Extract text from each page
        text = ''
        for page_num in range(len(pdf_reader.pages)):
            page = pdf_reader.pages[page_num]
            text += page.extract_text()

    # Save text to output file
    with open(output_path, 'w', encoding='utf-8') as txt_file:
        txt_file.write(text)

    print(f'Text extracted from {pdf_path} and saved to {output_path}')
