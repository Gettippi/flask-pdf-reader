from flask import Flask, request, jsonify
from paddleocr import PaddleOCR
from werkzeug.utils import secure_filename
import os
import gc

app = Flask(__name__)

# Initialize PaddleOCR
ocr = PaddleOCR(use_angle_cls=True, lang='en')

# Temporary folder to save uploaded files
UPLOAD_FOLDER = './uploads'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/extract-text', methods=['POST'])
def extract_text():
    if 'pdf' not in request.files:
        return jsonify({"error": "No PDF file provided"}), 400

    pdf_file = request.files['pdf']
    filename = secure_filename(pdf_file.filename)
    file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    pdf_file.save(file_path)

    try:
        # Use PaddleOCR to extract text
        
        result = ocr.ocr(file_path, cls=True)
        text = "\n".join([line[1][0] for page in result for line in page])
        os.remove(file_path)  # Clean up the uploaded file
        return jsonify({"text": text}), 200
    except Exception as e:
        os.remove(file_path)  # Clean up the uploaded file in case of error
        return jsonify({"error": str(e)}), 500
    finally:
        # Clean up any remaining garbage
        del result
        gc.collect()

# if __name__ == '__main__':
#     app.run(
#         debug=True,
#         host='0.0.0.0'
#     )
