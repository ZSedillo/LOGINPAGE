package controller;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PDFServlet extends HttpServlet {
    String jdbcUrl;
    String dbUsername;
    String dbPassword;
    int totalAmountofPage = 1;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        OutputStream out = response.getOutputStream();

        jdbcUrl = (String) session.getAttribute("jdbcUrl");
        dbUsername = (String) session.getAttribute("dbUsername");
        dbPassword = (String) session.getAttribute("dbPassword");

//        PDF pdf = new PDF(jdbcUrl, dbUsername, dbPassword);
        System.out.print("connection: " + jdbcUrl);

        String currentUsername = (String) session.getAttribute("username");
        Boolean result;
        String currentUser = (String) session.getAttribute("currentUser");
        if (currentUser == "Admin") {
            generatePDF(true, currentUsername, response);
        } else {
            generatePDF(false, currentUsername, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    public void generatePDF(boolean isAdmin, String username, HttpServletResponse response) {
        try {
            response.setContentType("application/pdf");
            OutputStream out = response.getOutputStream();

            if (isAdmin == true) {
                response.setHeader("Content-Disposition", "attachment; filename=\"AdminReport.pdf\"");
                generateAdminPDF(username, out);
            } else {
                response.setHeader("Content-Disposition", "attachment; filename=\"GuestReport.pdf\"");
                generateGuestPDF(username, out);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    public void generateAdminPDF(String username, OutputStream out) {
    int pageSplit = 1;
    int recordNumber = 1; // Counter for numbering each row
    System.out.println("Generating report for admin....");
    try (Connection conn = getConnection()) {
        Document report = new Document();
        Rectangle pgsize = new Rectangle(PageSize.LETTER);
        report.setPageSize(pgsize);

        PdfWriter writer = PdfWriter.getInstance(report, out);
        report.open();

        Paragraph typeofReport = new Paragraph("Admin Database Report", FontFactory.getFont(FontFactory.HELVETICA, 16, Font.BOLDITALIC));
        typeofReport.setAlignment(Element.ALIGN_CENTER);
        report.add(typeofReport);

        String query = "SELECT USERNAME, ROLE FROM USER_INFO";
        try (PreparedStatement statement = conn.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {
            report.add(new Paragraph("\n\n\n"));

            PdfPTable table = new PdfPTable(3); // Now three columns: #, username, and role
            PdfPCell numberCell = new PdfPCell(new Paragraph("#"));
            numberCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            PdfPCell cell1 = new PdfPCell(new Paragraph("Username"));
            cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
            PdfPCell cell2 = new PdfPCell(new Paragraph("Role"));
            cell2.setHorizontalAlignment(Element.ALIGN_CENTER);

            numberCell.setBackgroundColor(BaseColor.RED);
            cell1.setBackgroundColor(BaseColor.RED);
            cell2.setBackgroundColor(BaseColor.RED);

            table.addCell(numberCell);
            table.addCell(cell1);
            table.addCell(cell2);

            while (rs.next()) {
                PdfPCell numCell = new PdfPCell(new Paragraph(String.valueOf(recordNumber++)));
                numCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                PdfPCell usernameCell = new PdfPCell(new Paragraph(rs.getString("USERNAME").trim()));
                usernameCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                PdfPCell roleCell = new PdfPCell(new Paragraph(rs.getString("ROLE").trim()));
                roleCell.setHorizontalAlignment(Element.ALIGN_CENTER);

                table.addCell(numCell);
                table.addCell(usernameCell);
                table.addCell(roleCell);
                pageSplit++;
                
                if(pageSplit == 34 || pageSplit % 100 == 0){
                    totalAmountofPage++;
                }
            }

            writer.setPageEvent(new PdfPageEventHelper() {
                @Override
                public void onEndPage(PdfWriter writer, Document document) {
                    PdfContentByte cb = writer.getDirectContent();
                    Phrase footer = new Phrase(String.format("Page %d of %d", writer.getPageNumber(), totalAmountofPage), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.ITALIC));
                    Phrase owner = new Phrase(username, FontFactory.getFont(FontFactory.HELVETICA, 8, Font.ITALIC));
                    ColumnText.showTextAligned(cb, Element.ALIGN_LEFT, owner, document.left() + document.leftMargin(), document.bottom() - 10, 0);
                    ColumnText.showTextAligned(cb, Element.ALIGN_RIGHT, footer, document.right() - document.rightMargin(), document.bottom() - 10, 0);
                }
            });

            report.add(table);
            report.close();

            System.out.println("Done generating reports for admin!");
            totalAmountofPage = 1;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}

public void generateGuestPDF(String username, OutputStream out) {
    System.out.println("Generating report for guest....");
    try (Connection conn = getConnection()) {
        Document report = new Document();
        Rectangle customPageSize = new Rectangle(500, 200);
        report.setPageSize(customPageSize);

        PdfWriter writer = PdfWriter.getInstance(report, out);
        writer.setPageEvent(new PdfPageEventHelper() {
            int totalPages = 0;

            @Override
            public void onStartPage(PdfWriter writer, Document document) {
                totalPages++;
            }

            @Override
            public void onEndPage(PdfWriter writer, Document document) {
                PdfContentByte cb = writer.getDirectContent();
                Phrase footer = new Phrase(String.format("Page %d of %d", writer.getPageNumber(), totalPages), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.ITALIC));
                Phrase owner = new Phrase(username, FontFactory.getFont(FontFactory.HELVETICA, 8, Font.ITALIC));
                ColumnText.showTextAligned(cb, Element.ALIGN_LEFT, owner, document.left() + document.leftMargin(), document.bottom() - 10, 0);
                ColumnText.showTextAligned(cb, Element.ALIGN_RIGHT, footer, document.right() - document.rightMargin(), document.bottom() - 10, 0);
            }
        });
        report.open();

        Paragraph typeofReport = new Paragraph("Guest Database Report", FontFactory.getFont(FontFactory.HELVETICA, 16, Font.BOLDITALIC));
        typeofReport.setAlignment(Element.ALIGN_CENTER);
        report.add(typeofReport);

        String query = "SELECT USERNAME, PASSWORD FROM USER_INFO WHERE USERNAME = ?";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setString(1, username);
            try (ResultSet rs = statement.executeQuery()) {
                report.add(new Paragraph("\n\n\n"));
                
                while (rs.next()) {
                    Paragraph userInfo = new Paragraph(String.format("Username: %s\nPassword: %s", rs.getString("USERNAME").trim(), rs.getString("PASSWORD").trim()), FontFactory.getFont(FontFactory.HELVETICA, 12, Font.NORMAL));
                    userInfo.setAlignment(Element.ALIGN_CENTER);
                    report.add(userInfo);
                }

                report.close();
                System.out.println("Done generating reports for guest!");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}

    
         private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);
    }   
    

}
