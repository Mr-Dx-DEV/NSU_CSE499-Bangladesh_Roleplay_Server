"""
PDF Generator for NSU CSE499 Final Presentation
Generates a professionally designed PDF from all markdown files
"""

from reportlab.lib.pagesizes import letter, A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak, Table, TableStyle, Image
from reportlab.lib.enums import TA_CENTER, TA_LEFT, TA_JUSTIFY
from reportlab.lib import colors
from reportlab.pdfgen import canvas
import os
from datetime import datetime

class NumberedCanvas(canvas.Canvas):
    """Custom canvas for page numbers and headers"""
    def __init__(self, *args, **kwargs):
        canvas.Canvas.__init__(self, *args, **kwargs)
        self._saved_page_states = []

    def showPage(self):
        self._saved_page_states.append(dict(self.__dict__))
        self._startPage()

    def save(self):
        num_pages = len(self._saved_page_states)
        for state in self._saved_page_states:
            self.__dict__.update(state)
            self.draw_page_number(num_pages)
            canvas.Canvas.showPage(self)
        canvas.Canvas.save(self)

    def draw_page_number(self, page_count):
        self.setFont("Helvetica", 9)
        self.setFillColor(colors.grey)
        self.drawRightString(7.5*inch, 0.5*inch, f"Page {self._pageNumber} of {page_count}")
        self.drawString(1*inch, 0.5*inch, "NSU CSE499 - GTA V Roleplay Server")

def create_styles():
    """Create custom paragraph styles"""
    styles = getSampleStyleSheet()

    # Title style
    styles.add(ParagraphStyle(
        name='CustomTitle',
        parent=styles['Heading1'],
        fontSize=24,
        textColor=colors.HexColor('#1a237e'),
        spaceAfter=30,
        alignment=TA_CENTER,
        fontName='Helvetica-Bold'
    ))

    # Heading 1
    styles.add(ParagraphStyle(
        name='CustomH1',
        parent=styles['Heading1'],
        fontSize=18,
        textColor=colors.HexColor('#0d47a1'),
        spaceAfter=12,
        spaceBefore=16,
        fontName='Helvetica-Bold',
        borderPadding=5,
        backColor=colors.HexColor('#e3f2fd')
    ))

    # Heading 2
    styles.add(ParagraphStyle(
        name='CustomH2',
        parent=styles['Heading2'],
        fontSize=14,
        textColor=colors.HexColor('#1565c0'),
        spaceAfter=10,
        spaceBefore=12,
        fontName='Helvetica-Bold'
    ))

    # Heading 3
    styles.add(ParagraphStyle(
        name='CustomH3',
        parent=styles['Heading3'],
        fontSize=12,
        textColor=colors.HexColor('#1976d2'),
        spaceAfter=8,
        spaceBefore=10,
        fontName='Helvetica-Bold'
    ))

    # Body text
    styles.add(ParagraphStyle(
        name='CustomBody',
        parent=styles['BodyText'],
        fontSize=10,
        leading=14,
        alignment=TA_JUSTIFY,
        spaceAfter=8
    ))

    # Code style
    styles.add(ParagraphStyle(
        name='CustomCode',
        parent=styles['Code'],
        fontSize=9,
        fontName='Courier',
        backColor=colors.HexColor('#f5f5f5'),
        borderColor=colors.HexColor('#e0e0e0'),
        borderWidth=1,
        borderPadding=10,
        leftIndent=20,
        rightIndent=20,
        spaceAfter=10
    ))

    # List item
    styles.add(ParagraphStyle(
        name='CustomList',
        parent=styles['BodyText'],
        fontSize=10,
        leftIndent=30,
        spaceAfter=6,
        bulletIndent=20
    ))

    return styles

def markdown_to_flowables(md_file, styles):
    """Convert markdown content to reportlab flowables"""
    flowables = []

    if not os.path.exists(md_file):
        return flowables

    with open(md_file, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    in_code_block = False
    code_lines = []

    for line in lines:
        line = line.rstrip()

        # Handle code blocks
        if line.startswith('```'):
            if in_code_block:
                # End code block
                code_text = '<font name="Courier" size="8">' + '<br/>'.join(code_lines) + '</font>'
                flowables.append(Paragraph(code_text, styles['CustomCode']))
                code_lines = []
                in_code_block = False
            else:
                # Start code block
                in_code_block = True
            continue

        if in_code_block:
            # Escape XML special characters
            line = line.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
            code_lines.append(line)
            continue

        # Skip empty lines
        if not line.strip():
            flowables.append(Spacer(1, 0.1*inch))
            continue

        # Handle headers
        if line.startswith('# '):
            text = line[2:].strip()
            flowables.append(Paragraph(text, styles['CustomTitle']))
        elif line.startswith('## '):
            text = line[3:].strip()
            flowables.append(Paragraph(text, styles['CustomH1']))
        elif line.startswith('### '):
            text = line[4:].strip()
            flowables.append(Paragraph(text, styles['CustomH2']))
        elif line.startswith('#### '):
            text = line[5:].strip()
            flowables.append(Paragraph(text, styles['CustomH3']))

        # Handle horizontal rules
        elif line.startswith('---'):
            flowables.append(Spacer(1, 0.2*inch))

        # Handle lists
        elif line.startswith('- ') or line.startswith('* '):
            text = '• ' + line[2:].strip()
            # Escape XML
            text = text.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
            # Handle bold
            while '**' in text:
                text = text.replace('**', '<b>', 1).replace('**', '</b>', 1)
            # Handle code
            parts = text.split('`')
            for i in range(1, len(parts), 2):
                if i < len(parts):
                    parts[i] = f'<font name="Courier" size="9">{parts[i]}</font>'
            text = ''.join(parts)
            # Unescape allowed tags
            text = text.replace('&lt;b&gt;', '<b>').replace('&lt;/b&gt;', '</b>')
            text = text.replace('&lt;font', '<font').replace('&lt;/font&gt;', '</font>')
            flowables.append(Paragraph(text, styles['CustomList']))

        elif line.strip().startswith('✅'):
            text = line.strip()
            # Escape XML
            text = text.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
            # Handle bold
            while '**' in text:
                text = text.replace('**', '<b>', 1).replace('**', '</b>', 1)
            # Unescape allowed tags
            text = text.replace('&lt;b&gt;', '<b>').replace('&lt;/b&gt;', '</b>')
            flowables.append(Paragraph(text, styles['CustomList']))

        # Handle tables (basic support)
        elif '|' in line and not line.startswith('#'):
            # Skip for now - tables are complex
            continue

        # Handle regular paragraphs
        else:
            text = line.strip()
            if text:
                # Escape XML special characters first
                text = text.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')

                # Replace markdown bold with XML tags (match pairs)
                while '**' in text:
                    text = text.replace('**', '<b>', 1).replace('**', '</b>', 1)

                # Replace inline code (handle backticks)
                parts = text.split('`')
                for i in range(1, len(parts), 2):
                    if i < len(parts):
                        parts[i] = f'<font name="Courier" size="9">{parts[i]}</font>'
                text = ''.join(parts)

                # Unescape for allowed tags
                text = text.replace('&lt;b&gt;', '<b>').replace('&lt;/b&gt;', '</b>')
                text = text.replace('&lt;i&gt;', '<i>').replace('&lt;/i&gt;', '</i>')
                text = text.replace('&lt;font', '<font').replace('&lt;/font&gt;', '</font>')

                flowables.append(Paragraph(text, styles['CustomBody']))

    return flowables

def create_pdf(output_file='NSU_CSE499_Complete_Documentation.pdf'):
    """Create the complete PDF document"""

    # Create PDF
    doc = SimpleDocTemplate(
        output_file,
        pagesize=letter,
        rightMargin=72,
        leftMargin=72,
        topMargin=72,
        bottomMargin=72,
    )

    # Container for the 'Flowable' objects
    elements = []

    # Get styles
    styles = create_styles()

    # Cover Page
    elements.append(Spacer(1, 2*inch))
    elements.append(Paragraph("NSU CSE499 Final Project", styles['CustomTitle']))
    elements.append(Spacer(1, 0.3*inch))
    elements.append(Paragraph("GTA V Roleplay Server", styles['CustomH1']))
    elements.append(Paragraph("Qbox Framework Implementation", styles['CustomH2']))
    elements.append(Spacer(1, 0.5*inch))
    elements.append(Paragraph("Complete Documentation Package", styles['CustomBody']))
    elements.append(Spacer(1, 0.3*inch))

    # Date
    date_str = datetime.now().strftime("%B %d, %Y")
    elements.append(Paragraph(f"Generated: {date_str}", styles['CustomBody']))
    elements.append(PageBreak())

    # Table of Contents
    elements.append(Paragraph("Table of Contents", styles['CustomTitle']))
    elements.append(Spacer(1, 0.3*inch))

    toc_items = [
        "1. Main Presentation",
        "2. Executive Summary",
        "3. Demo Script",
        "4. Technical Documentation",
        "5. Frequently Asked Questions (FAQ)",
        "6. Complete Feature List",
        "7. Installation & Setup Guide"
    ]

    for item in toc_items:
        elements.append(Paragraph(item, styles['CustomList']))

    elements.append(PageBreak())

    # List of files to include
    files = [
        ('01_MAIN_PRESENTATION.md', '1. Main Presentation'),
        ('02_EXECUTIVE_SUMMARY.md', '2. Executive Summary'),
        ('03_DEMO_SCRIPT.md', '3. Demo Script'),
        ('04_TECHNICAL_DOCUMENTATION.md', '4. Technical Documentation'),
        ('05_FAQ.md', '5. Frequently Asked Questions'),
        ('06_FEATURE_LIST.md', '6. Complete Feature List'),
        ('07_INSTALLATION_GUIDE.md', '7. Installation & Setup Guide')
    ]

    # Process each file
    for filename, section_title in files:
        # Section title page
        elements.append(Spacer(1, 2*inch))
        elements.append(Paragraph(section_title, styles['CustomTitle']))
        elements.append(Spacer(1, 0.5*inch))
        elements.append(PageBreak())

        # Add content
        file_elements = markdown_to_flowables(filename, styles)
        elements.extend(file_elements)
        elements.append(PageBreak())

    # Build PDF
    print(f"Generating PDF: {output_file}")
    doc.build(elements, canvasmaker=NumberedCanvas)
    print(f"PDF generated successfully: {output_file}")
    print(f"Total pages: {len(elements) // 20}")  # Rough estimate

if __name__ == "__main__":
    print("NSU CSE499 PDF Generator")
    print("=" * 50)
    create_pdf()
