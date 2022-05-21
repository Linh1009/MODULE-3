use furamamanagers;
-- 8. Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau
-- cách 1
 select kh.ho_ten from khach_hang kh WHERE 1=1
 and kh.ho_ten NOT IN (
 SELECT kh.ho_ten
FROM khach_hang kh
HAVING COUNT(kh.ho_ten) > 1
 );
 -- cách 2
 select kh.ho_ten from khach_hang kh
 INNER JOIN (
 SELECT kh.ma_khach_hang
FROM khach_hang kh
GROUP BY kh.ho_ten
HAVING COUNT(kh.ho_ten) = 1) AS T ON T.ma_khach_hang = kh.ma_khach_hang
GROUP BY kh.ho_ten;
-------------------------------------------------------------------------------------------------
--- 9. Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021 thì sẽ có bao nhiêu
-- khách hàng thực hiện đặt phòng.


SELECT	MONTH(hd.ngay_lam_hop_dong) as thang, COUNT(hd.ma_khach_hang) as soluong
FROM		hop_dong hd
WHERE	YEAR(hd.ngay_lam_hop_dong)=2021 
GROUP BY	MONTH(hd.ngay_lam_hop_dong)
ORDER BY MONTH(hd.ngay_lam_hop_dong) asc;

-- 10.Hiển thị thông tin tương ứ ng với từng hợp đồ ng thì đã sử dụng bao nhiêu dịch vụ đ i kèm.Kết quả hiển thị bao gồm ma_hop_dong,
-- ngay_lam_hop_dong,
-- ngay_ket_thuc,
-- tien_dat_coc,
-- so_luong_dich_vu_di_kem (đượ c tính dựa trên việc sum so_luong ở dich_vu_di_kem ).

SELECT
	hd.ma_hop_dong,
	hd.ngay_lam_hop_dong,
	hd.ngay_ket_thuc,
	hd.tien_dat_coc,
	sum( ct.so_luong ) AS so_luong_dich_vu_di_kem 
FROM
	hop_dong hd
	left JOIN hop_dong_chi_tiet ct ON hd.ma_hop_dong = ct.ma_hop_dong 
GROUP BY
	hd.ma_hop_dong;
    
    -------------------------------------------------------------------------------------------------
-- 11.	Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” và có -- dia_chi ở “Vinh” hoặc “Quảng Ngãi”.

select dvdk.* from dich_vu_di_kem dvdk
INNER JOIN hop_dong_chi_tiet ct ON ct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
INNER JOIN hop_dong hd ON hd.ma_hop_dong = ct.ma_hop_dong
INNER JOIN khach_hang kh ON kh.ma_khach_hang = hd.ma_khach_hang AND kh.dia_chi REGEXP 'Vinh|Quảng Ngãi$'
INNER JOIN loai_khach lk ON lk.ma_loai_khach = kh.ma_loai_khach AND lk.ten_loai_khach = 'Diamond';

-- 12.Hiển thị thông tin ma_hop_dong,
-- ho_ten ( nhân viên ),
-- ho_ten ( khách hàng ),
-- so_dien_thoai ( khách hàng ),
-- ten_dich_vu,
-- so_luong_dich_vu_di_kem (đượ c tính dựa trên việc sum so_luong ở dich_vu_di_kem ),
-- tien_dat_coc của tất cả các dịch vụ đã từng đượ c khách hàng đặ t vào 3 tháng cuối năm 2020 nhưng chưa từng đượ c -- khách hàng đặ t vào 6 tháng đầ u năm 2021.
SELECT
	hd.ma_hop_dong,
	nv.ho_ten  as ten_nhan_vien,
	kh.ho_ten as ten_khach_hang,
	kh.so_dien_thoai as so_dien_thoai_khach_hang,
	dv.ten_dich_vu_di_kem,
	sum( ct.so_luong ) AS so_luong_dich_vu_di_kem 
FROM
	hop_dong hd
	INNER JOIN hop_dong_chi_tiet ct ON hd.ma_hop_dong = ct.ma_hop_dong
	INNER JOIN khach_hang kh ON kh.ma_khach_hang = hd.ma_khach_hang
	INNER JOIN nhan_vien nv ON nv.ma_nhan_vien = hd.ma_nhan_vien
	INNER JOIN dich_vu_di_kem dv ON dv.ma_dich_vu_di_kem = ct.ma_dich_vu_di_kem 
	WHERE hd.ma_hop_dong IN (
	select hd.ma_hop_dong from hop_dong hd
	WHERE year(hd.ngay_lam_hop_dong) = 2020
	AND month(hd.ngay_lam_hop_dong) >= 10
	)
	AND hd.ma_hop_dong  NOT IN (
	select hd.ma_hop_dong from hop_dong hd
	WHERE year(hd.ngay_lam_hop_dong) = 2021
	AND month(hd.ngay_lam_hop_dong) <= 6
	)
GROUP BY
	hd.ma_hop_dong;

-- 13.Hiển thị thông tin các Dịch vụ đ i kèm đượ c sử dụng nhiều nhất bởi các Khách hàng đã đặ t phòng.
-- ( Lưu ý là có thể -- có nhiều dịch vụ có số lần sử dụng nhiều như nhau ).

SELECT 
	dv.ten_dich_vu_di_kem,
	sum( ct.so_luong ) AS so_luong_dich_vu_di_kem 
FROM
	hop_dong hd
	INNER JOIN hop_dong_chi_tiet ct ON hd.ma_hop_dong = ct.ma_hop_dong
	INNER JOIN dich_vu_di_kem dv ON dv.ma_dich_vu_di_kem = ct.ma_dich_vu_di_kem 
GROUP BY
	hd.ma_hop_dong
	ORDER BY so_luong_dich_vu_di_kem desc;
	
    -- 14.Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).
SELECT hd.ma_hop_dong,ldv.ten_loai_dich_vu ,di_kem.ten_dich_vu_di_kem, COUNT(di_kem.ten_dich_vu_di_kem) as so_lan_su_dung from 
hop_dong hd
inner JOIN dich_vu dv ON dv.ma_dich_vu = hd.ma_dich_vu
inner join loai_dich_vu ldv on ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu
inner JOIN hop_dong_chi_tiet ct ON ct.ma_hop_dong = hd.ma_hop_dong
RIGHT JOIN dich_vu_di_kem di_kem ON di_kem.ma_dich_vu_di_kem = ct.ma_dich_vu_di_kem
GROUP BY di_kem.ten_dich_vu_di_kem HAVING so_lan_su_dung =1
order by hd.ma_hop_dong asc;


-- 15.Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien,
-- ho_ten,
-- ten_trinh_do,
-- ten_bo_phan,
-- so_dien_thoai,
-- dia_chi mới chỉ lập đượ c tối đ a 3 hợp đồ ng từ năm 2020 đế n 2021.
use furamamanagers;
SELECT nv.ho_ten, td.ten_trinh_do, bp.ten_bo_phan, nv.so_dien_thoai,nv.dia_chi, COUNT(hd.ma_nhan_vien) as total FROM
hop_dong hd
INNER JOIN nhan_vien nv on nv.ma_nhan_vien = hd.ma_nhan_vien
inner JOIN trinh_do td on td.ma_trinh_do = nv.ma_trinh_do
INNER JOIN bo_phan bp on bp.ma_bo_phan = nv.ma_bo_phan
GROUP BY hd.ma_nhan_vien HAVING total < 3
