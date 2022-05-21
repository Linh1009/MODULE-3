use demo;
select * from products;
CREATE UNIQUE INDEX  productCode_fk
ON products (productCode);

CREATE UNIQUE INDEX  productCode_fk
ON products (productName , productPrice);

create view san_pham as
select productCode, productName, productPrice, product