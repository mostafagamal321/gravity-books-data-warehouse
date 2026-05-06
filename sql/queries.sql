select * from Dim_Shipping

select method_id , 
method_name , 
cost AS shipping_cost 
from gravity_books.dbo.shipping_method




select * from gravity_books.dbo.author;

select * from Dim_OrderStatus


select * from Dim_Author



select * from gravity_dwh.dbo.Dim_Book;


select b.book_id,
b.title ,
b.isbn13 ,
b.num_pages , 
b.publication_date , 
p.publisher_name , 
bl.language_name ,
bl.language_code
from book b
left join publisher p 
on b.publisher_id = p.publisher_id
left join book_language bl
on b.language_id = bl.language_id;