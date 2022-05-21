use demo;
 -- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product

DELIMITER //
DROP PROCEDURE IF EXISTS `GetAllProducts` //
 
CREATE PROCEDURE `GetAllProducts`()
BEGIN
   SELECT *  FROM products;
END
 
// DELIMITER ;

CALL GetAllProducts();
-- Tạo store procedure thêm một sản phẩm mới
DELIMITER //
 
DROP PROCEDURE IF EXISTS `them_sp` //
 
CREATE PROCEDURE `them_sp`(id int,
 productCode int,productName varchar(50), productPrice double, 
productAmount int, productDescription varchar(50),productStatus  varchar(50))
BEGIN
 insert into products (id ,
 productCode ,productName , productPrice , 
productAmount , productDescription ,productStatus ) values (id ,
 productCode ,productName , productPrice , 
productAmount , productDescription ,productStatus);
END 
 
// DELIMITER ;

call them_sp(10, 2, 'a', 2, 3, 'd', 'd');

-- Tạo store procedure sửa thông tin sản phẩm theo id
DELIMITER //
 
DROP PROCEDURE IF EXISTS `sua_thong_tin` //
 
CREATE PROCEDURE `sua_thong_tin`(id int,
 productCode int,productName varchar(50), productPrice double, 
productAmount int, productDescription varchar(50),productStatus  varchar(50))
BEGIN
update products
SET id = id,
 productCode =productCode ,productName = productName, productPrice = productPrice, 
productAmount = productAmount, productDescription = productDescription,productStatus = productStatus
WHERE id = id ;
END
 
// DELIMITER ;

-- Tạo store procedure xoá sản phẩm theo id
DELIMITER //
DROP PROCEDURE IF EXISTS `xoa_sp` //
 
CREATE PROCEDURE `xoa_sp`(id int)
BEGIN
delete from products 
Where id = id;
END
 
// DELIMITER ;

