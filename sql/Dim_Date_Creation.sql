Declare @startDate DATE  = '2000-01-01'
Declare @endDate Date = '2030-12-31'
Declare @CurrentDate Date = @startDate


INSERT INTO Dim_Date(
 date_sk, full_date, day_of_month, day_of_week,
    day_name, day_of_year, week_of_year, month_number,
    month_name, quarter_no, quarter_name, year_no,
    is_weekend, is_leap_year) 
    Values 
    ( -1  , 
    '1900-01-01' , 
    0 , 0 , 'Unknown' , 0 ,0 , 0 ,
    'Unknown', 0  ,'UU', 0, 0 , 0);




    WHILE @CurrentDate <= @endDate
    BEGIN 
        INSERT INTO Dim_Date( 
        date_sk, 
        full_date, 
        day_of_month,
        day_of_week,
        day_name,
        day_of_year, 
        week_of_year,
        month_number,
        month_name,
        quarter_no,
        quarter_name,
        year_no,
        is_weekend,
        is_leap_year
    )
    Values ( 
    Year(@CurrentDate) * 10000 + MONTH(@CurrentDate) * 100 + Day(@CurrentDate),
    @CurrentDate,
    Day(@CurrentDate),
    DATEPART(WEEKDAY , @CurrentDate),
    DATENAME(WEEKDAY , @CurrentDate),
    DATEPART(DAYOFYEAR , @CurrentDate),
    DATEPART(Week , @CurrentDate),
    MONTH(@CurrentDate),
    DATENAME(Month , @CurrentDate),
    DATEPART(QUARTER , @CurrentDate),
    'Q' + CAST(DATEPART(QUARTER , @CurrentDate) AS varchar),
    YEAR(@CurrentDate),
    CASE
        WHEN DATENAME(WEEKDAY , @CurrentDate) IN ('Saturday','Sunday')
        THEN 1 ELSE 0
    END,

    CASE 
        WHEN (YEAR(@CurrentDate) % 4 = 0
             AND YEAR(@CurrentDate) % 100 != 0)
             OR (YEAR(@CurrentDate) % 400 = 0)
        THEN 1 ELSE 0 
    END 
)

    SET @CurrentDate  = DATEADD(DAY , 1 , @CurrentDate)
END

GO

