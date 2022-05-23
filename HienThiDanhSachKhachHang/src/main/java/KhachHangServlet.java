import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@javax.servlet.annotation.WebServlet(name = "KhachHangServlet")
public class KhachHangServlet extends HttpServlet {
    public static List<KhachHang> khachHangList = new ArrayList<>();
    @Override
    public void init() throws ServletException {
        khachHangList.add(new KhachHang(1, "Mai Văn Hoan","20/08/1983","Hà Nội"));
        khachHangList.add(new KhachHang(1, "Nguyễn Văn Nam","20/08/1983","Hà Nội"));
        khachHangList.add(new KhachHang(1, "Nguyễn Thái Hòa","20/08/1983","Hà Nội"));
        khachHangList.add(new KhachHang(1, "Trần Đăng KHoa","20/08/1983","Hà Nội"));
        khachHangList.add(new KhachHang(1, "Nguyễn Đình Thi","20/08/1983","Hà Nội"));

    }

    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {

    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {

    }
}
