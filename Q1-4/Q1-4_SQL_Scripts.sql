/*Creating STORE_SALES table*/
CREATE TABLE STORE_SALES(
  STORE INT,
  SALES_DATE VARCHAR(10),
  SALES DECIMAL(10,2)
);

INSERT INTO STORE_SALES(STORE,SALES_DATE,SALES) VALUES(1,'01-31-2017',100);
INSERT INTO STORE_SALES(STORE,SALES_DATE,SALES) VALUES(1,'02-01-2017',110);
INSERT INTO STORE_SALES(STORE,SALES_DATE,SALES) VALUES(1,'02-02-2017',111);
INSERT INTO STORE_SALES(STORE,SALES_DATE,SALES) VALUES(2,'01-31-2016',130);
INSERT INTO STORE_SALES(STORE,SALES_DATE,SALES) VALUES(2,'02-01-2016',132);
INSERT INTO STORE_SALES(STORE,SALES_DATE,SALES) VALUES(2,'02-02-2016',133);
INSERT INTO STORE_SALES(STORE,SALES_DATE,SALES) VALUES(2,'02-03-2016',139);
SELECT * FROM STORE_SALES;

/*Creating STORE_LOCATION table*/
CREATE TABLE STORE_LOCATION(
  STORE INT,
  LATITUDE DECIMAL(10,6),
  LONGITUDE DECIMAL(10,6),
  REGION INT
);

INSERT INTO STORE_LOCATION(STORE,LATITUDE,LONGITUDE,REGION) VALUES(1,35.467560,-97.516430,1);
INSERT INTO STORE_LOCATION(STORE,LATITUDE,LONGITUDE,REGION) VALUES(2,39.961180,-82.998790,2);
INSERT INTO STORE_LOCATION(STORE,LATITUDE,LONGITUDE,REGION) VALUES(3,35.686980,-105.937800,1);
INSERT INTO STORE_LOCATION(STORE,LATITUDE,LONGITUDE,REGION) VALUES(4,41.600540,-93.609110,3);
SELECT * FROM STORE_LOCATION;

/*Creating STORE_LOCATION table*/
CREATE TABLE WEATHER(
  LATITUDE DECIMAL(10,7),
  LONGITUDE DECIMAL(10,7),
  OBS_DATE VARCHAR(10),
  PRECIP DECIMAL(10,2)
);

INSERT INTO WEATHER(LATITUDE,LONGITUDE,OBS_DATE,PRECIP) VALUES(35.7478769,-95.3696909,'01-31-2017',0.00);
INSERT INTO WEATHER(LATITUDE,LONGITUDE,OBS_DATE,PRECIP) VALUES(35.657295,-97.478256,'01-31-2017',0.00);
INSERT INTO WEATHER(LATITUDE,LONGITUDE,OBS_DATE,PRECIP) VALUES(34.603565,-98.395927,'01-31-2017',1.01);
INSERT INTO WEATHER(LATITUDE,LONGITUDE,OBS_DATE,PRECIP) VALUES(35.9116725,-94.977615,'01-31-2017',0.00);
INSERT INTO WEATHER(LATITUDE,LONGITUDE,OBS_DATE,PRECIP) VALUES(35.657295,-97.478256,'02-01-2017',0.00);
INSERT INTO WEATHER(LATITUDE,LONGITUDE,OBS_DATE,PRECIP) VALUES(35.7478769,-95.3696909,'02-01-2017',2.17);
select * from WEATHER;


/*Q1 What would a query to pull total sales look like?*/
SELECT SUM(SALES) AS Total_Sales FROM STORE_SALES;

/*Q2What would a query to pull sales by region look like?*/
SELECT REGION,SUM(SALES) AS Sales_by_Region FROM STORE_SALES ss JOIN STORE_LOCATION sl ON ss.STORE=sl.STORE GROUP BY REGION;

/*Q3Write a query to determine how far from each store the PRECIP values were collected.*/
--select sl.store,ROUND(ACOS(SIN(sl.latitude*ACOS(-1)/180)*SIN(w.latitude*ACOS(-1)/180) + COS(sl.latitude*ACOS(-1)/180)*COS(w.latitude*ACOS(-1)/180)*COS(w.longitude*ACOS(-1)/180-sl.longitude*ACOS(-1)/180) ) * 3981.875,2) as distance_in_miles,sl.latitude,sl.longitude,w.latitude,w.longitude,w.obs_date,w.precip from store_location sl,weather w order by sl.STORE,w.OBS_DATE;
select sl.store,ROUND(ACOS(SIN(sl.latitude*ACOS(-1)/180)*SIN(w.latitude*ACOS(-1)/180) + COS(sl.latitude*ACOS(-1)/180)*COS(w.latitude*ACOS(-1)/180)*COS(w.longitude*ACOS(-1)/180-sl.longitude*ACOS(-1)/180) ) * 3981.875,2) AS Distance_in_Miles,w.obs_date,w.precip from store_location sl,weather w order by sl.STORE,w.OBS_DATE;

/*Q4Write a query to determine if PRECIP values impacted store sales.*/
select sl.STORE,ROUND(ACOS(SIN(sl.LATITUDE*ACOS(-1)/180)*SIN(w.LATITUDE*ACOS(-1)/180) + COS(sl.LATITUDE*ACOS(-1)/180)*COS(w.LATITUDE*ACOS(-1)/180)*COS(w.LONGITUDE*ACOS(-1)/180-sl.LONGITUDE*ACOS(-1)/180) ) * 3981.875,2) AS Distance_in_Miles, w.OBS_DATE,w.PRECIP,ss.SALES from STORE_LOCATION sl,WEATHER w,STORE_SALES ss where sl.STORE=ss.STORE and ss.SALES_DATE=w.OBS_DATE order by sl.STORE,w.OBS_DATE;