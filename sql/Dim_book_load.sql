	select * from book;
	select * from publisher;
	select * from book_language;


	select * from gravity_dwh.dbo.Dim_Book;


	select b.book_id ,
	b.title , 
	b.isbn13 , 
	b.num_pages , 
	b.publication_date ,
	p.publisher_name ,
	bl.language_name ,
	bl.language_code 
	
	from book b 
	left join publisher p
	on b.publisher_id  = p.publisher_id
	left join book_language bl
	on b.language_id = bl.language_id;


