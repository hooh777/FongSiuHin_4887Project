LIBNAME ITP4887 '/home/u62649338/ITP4887_GrpProject';
RUN;


PROC IMPORT
	out= ITP4887.housingData
	datafile = "/home/u62649338/ITP4887_GrpProject/Project_Housing.csv"
	dbms = CSV
	replace; 
RUN;

*Q1;
PROC PRINT DATA = ITP4887.housingDATA(OBS = 9);
RUN;


*Q2;
PROC SQL;
	CREATE TABLE Q2 AS
	SELECT AVG(TotalBaths) AS AvgTotalBaths, FlatType FROM ITP4887.housingDATA
	GROUP BY FlatType;
	
	SELECT * FROM Q2;
RUN;


PROC SGPLOT DATA = Q2;
	TITLE "Bar Chart of the Number of Bathroom of Property on Average";
    VBAR FlatType/ RESPONSE = AvgTotalBaths
    colorresponse=AvgTotalBaths
    colormodel=(yellow gold orange)
    categoryorder=respdesc;
RUN;


*Q3;
PROC SQL;
	CREATE TABLE Q3 AS
	SELECT FlatType, COUNT(FlatType) AS numOfFlat FROM ITP4887.housingDATA
	GROUP BY FlatType;
	
	SELECT * FROM Q3;
RUN; 


PROC SGPIE DATA = Q3;
	TITLE "Proportion of House Type";
		PIE FlatType / RESPONSE = numOfFlat;
		
RUN;


*Q4;
PROC SQL;
	CREATE TABLE Q4 AS
	SELECT FlatType, TotalReceptions FROM ITP4887.housingDATA
	WHERE FlatType = "semi-detached house" OR FlatType = "terraced house"
	GROUP BY FlatType;
	
	SELECT * FROM Q4;
RUN; 


PROC SGPLOT  DATA = Q4;
   VBOX TotalReceptions 
   / CATEGORY = FlatType
   DATALABEL = TotalReceptions
   DISPLAYSTATS = ALL
   fillattrs=(color = orange);
   TITLE 'Distribution of the Number of Reception Between the Semi-detached House and Terraced House';
RUN;


*Q5;
PROC SQL;
	CREATE TABLE Q5 AS	
	SELECT FlatType, SUM(Price) AS totalPrice FROM ITP4887.housingDATA
	GROUP BY FlatType
	ORDER BY totalPrice;
	SELECT * FROM Q5;
RUN;

PROC SGPLOT DATA = Q5;
	VBAR FlatType/ RESPONSE = totalPrice
	colorresponse=totalPrice
    colormodel=(yellow gold orange)
    categoryorder=respdesc;
    TITLE "Level of turnover of Property";
RUN;


*Q6;
PROC SQL;
	CREATE TABLE Q6 AS
	SELECT FlatType, AVG(TotalBeds) AS AvgBeds, AVG(TotalBaths)AS AvgBaths, AVG(price) AS AvgPrice FROM ITP4887.housingDATA
	GROUP BY FlatType;
	
	SELECT * FROM Q6;
RUN;
	
PROC SGPLOT DATA = Q6;
 SCATTER X = AvgBeds Y = AvgBaths / GROUP = FlatType;
 TITLE "Relationship between the number of bedrooms, the number of bathrooms and the average price of a different property";
RUN;

proc sgplot data=Q6;
  bubble x=AvgBeds y=AvgBaths size=AvgPrice / group=FlatType datalabel=FlatType 
    transparency=0.4 datalabelattrs=(size=5 weight=bold);
  inset "Bubble size represents AvgPrice" / position=bottomright textattrs=(size=11);
  yaxis grid;
  xaxis grid;




































