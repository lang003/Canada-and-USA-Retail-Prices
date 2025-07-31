/*Import all the csv files in SAS*/
data canada1;
	set canada; /*rename Import to Canada*/
	RetailPrice_Canadian= mean(of '22-jan'n '22-feb'n '22-mar'n '22-apr'n '22-may'n '22-jun'n '22-jul'n '22-aug'n
	 '22-sep'n '22-oct'n '22-nov'n '22-Dec'n); /*finding the mean of all months per each product*/ 
	 drop '22-'n:;
	 format RetailPrice_Canadian 5.2;
	 if find(products, 'beef', 'i') then delete; /*keeping the veggies and fruits*/
	 if find(products, 'pork', 'i') then delete;
     if find(products, 'egg', 'i') then delete;
     if find(products, 'milk', 'i') then delete;
     if find(products, 'chicken', 'i') then delete;
     if find(products, 'butter', 'i') then delete;
     if find(products, 'burger', 'i') then delete;
     if find(products, 'baby', 'i') then delete;
     if find(products, 'cream', 'i') then delete;
     if find(products, 'ketchup', 'i') then delete;
     if find(products, 'bacon', 'i') then delete;
     if find(products, 'wieners', 'i') then delete;
     if find(products, 'salmon', 'i') then delete;
     if find(products, 'tuna', 'i') then delete;
     if find(products, 'shrimp', 'i') then delete;
     if find(products, 'cheese', 'i') then delete;
     if find(products, 'salad', 'i') then delete;
     if find(products, 'bread', 'i') then delete;
     if find(products, 'pasta', 'i') then delete;
     if find(products, 'margarine', 'i') then delete;
     if find(products, 'pizza', 'i') then delete;
     if find(products, 'yogurt', 'i') then delete;
     if find(products, 'fried', 'i') then delete;
     if find(products, 'rice', 'i') then delete;
     if find(products, 'sugar', 'i') then delete;
       if find(products, 'flour', 'i') then delete;
      if find(products, 'cookies', 'i') then delete;
     if find(products, 'oil', 'i') then delete;
     if find(products, 'tea', 'i') then delete;
     if find(products, 'laundry', 'i') then delete;
     if find(products, 'shampoo', 'i') then delete;
     if find(products, 'tooth', 'i') then delete;
     if find(products, 'deodorant', 'i') then delete;
     if find(products, 'infant', 'i') then delete;
     if find(products, 'soup', 'i') then delete;
     if find(products, 'mayo', 'i') then delete;
     if find(products, 'coffee', 'i') then delete;
     if find(products, 'salsa', 'i') then delete;
     if find(products, 'cereal', 'i') then delete;
   if find(products, 'beans', 'i') then delete;
   if retailprice_Canadian=. then delete;
	run;
data canadaclean;
	set canada1;
	ProductName= scan(products, 1, ','); /*Keep the Product Name*/
	Remainder= scan(products,2, ',');
	 Unit= catx(' ', scan(remainder, 1, ' '), scan(remainder, 2, ' ')); /*get the unit for each product*/
	 if Unit= "unit 4" then Unit= "Unit"; /*rename for conisistency*/
	length Form $25; /*find the forms for each product*/
	Form= '';
	 
	 if substr(ProductName, 1, 7)= 'Canned ' then do;
	 	Form= 'Canned';
	 	ProductName = substr(ProductName, 8);
	 	end; 
	else if substr(ProductName, 1, 7)= 'Frozen' then do;
	 	Form = 'Frozen';
	 	ProductName =  substr(ProductName, 8);
	 	end;
	 else if substr(ProductName, 1, 6) = 'Dried ' then do;
	 	Form = 'Dried';
	 	ProductName= substr(ProductName, 7);
	 	end;
	 /*renaming for conisistency and drop additional information*/
	if ProductName= 'Apple juice' then Form= "Juice";
	if ProductName= 'Orange juice' then Form= "Juice";
	If ProductName= 'Apple juice' then ProductName= "Apple";
	if ProductName= 'Orange juice' then ProductName= "Orange";
	 drop Products Remainder;

	 RetailPrice_USA= RetailPrice_Canadian/1.3;
	 format RetailPrice_USA comma8.2;

	 	 if Form= '' then Form= "Fresh";
	 	 ProductName= propcase(ProductName);
	run;
proc sort data=canadaclean;
	by ProductName;
run;

data fruit1;
	set fruit;
	rename fruit= ProductName;
	run;

data Veggie1;
	set veggie;
	rename Vegetable= ProductName;
	run;
data USA; /*Merge all the data*/
	set fruit1 Veggie1;
	drop Cup:;
	ProductName = propcase(strip(compbl(tranwrd(lowcase(ProductName), 'ready-to-drink', ''))));
	run;

data USA1;
	set USA; /*renaming them again to match with Canada's products*/
	if index(lowcase(ProductName), 'apple') then ProductName= 'Apples';
	if index(lowcase(ProductName), 'apricot') then ProductName= 'Apricots';
	if index(lowcase(ProductName), 'cherries') then ProductName= 'Cherries';
	if index(lowcase(ProductName), 'fruit cocktail') then ProductName= 'Fruit Cocktail';
	if index(lowcase(ProductName), 'orange') then ProductName= 'Oranges';
	if index(lowcase(ProductName), 'peach') then ProductName= 'Peaches';
	if index(lowcase(ProductName), 'pear') then ProductName= 'Pears';
	if index(lowcase(ProductName), 'pineapple') then ProductName= 'Pineapples';
	if index(lowcase(ProductName), 'plum') then ProductName= 'Plums';
	if index(lowcase(ProductName), 'cabbage') then ProductName= 'Cabbages';
	if index(lowcase(ProductName), 'carrot') then ProductName= 'Carrots';
	if index(lowcase(ProductName), 'cauliflower') then ProductName= 'Cauliflower';
	if index(lowcase(ProductName), 'celery') then ProductName= 'Celery';
	if index(lowcase(ProductName), 'cucumber') then ProductName= 'Cucumbers';
	if index(lowcase(ProductName), 'grape') then ProductName= 'Grapes';
	if index(lowcase(ProductName), 'broccoli') then ProductName= 'Broccoli';
	if index(lowcase(ProductName), 'mushroom') then ProductName= 'Mushrooms';
	if index(lowcase(ProductName), 'potato') then ProductName= 'Potatoes';
	if index(lowcase(ProductName), 'tomato') then ProductName= 'Tomatoes';
	if index(lowcase(ProductName), 'spinach') then ProductName= 'Spinach';
	if index(lowcase(ProductName), 'pea') then ProductName= 'Peas';
	if index(lowcase(ProductName), 'pepper') then ProductName= 'Peppers';
	run;

proc sql; /*make a new table while only keeping the necessaries */
	create table  USAClean as
	select ProductName, Form, mean(RetailPrice) as RetailPrice_USA, RetailPriceUnit as Unit
	from USA1 group by ProductName, Form;
	quit;

proc sort data=USAClean nodupkey out=USAcleaned;
    by ProductName Form;
    format RetailPrice_USA comma8.2;
run;
	
data USAClean1;
	set usacleaned;
	if Unit= "per pound" then do; /*change lb to kg and cups to millilitres*/
	Unit2= 1* 0.4536;
		end;
	else if Unit= "per pint" then do;
	Unit2= 1*473.176;
		end;
	format Unit3 $25.;
	if Unit2= 0.4536 then Unit3= "kilogram";
	if Unit2= 473.176 then Unit3= "millilitres";
	drop Unit;
	format RetailPrice_Canadian comma8.2;
	RetailPrice_Canadian= RetailPrice_USA*1.3; /*retail conversions*/
	
run;

	
