%Heading
%NE389 - CDT Matthew Eckert
%Using the Bayesloc Output data, Plot the information on the earth.
%Must put Bayesloc Data in Directory "BayeslocOutput\" and all data must be
%labeled with their test number.
% Yeah im just hard coding it.
%-----------------------------------------------------------
semimajor = km2deg(6);
ecc = axes2ecc(semimajor, km2deg(6));
[lat,lon] = ellipse1(41.3057,129.078,[semimajor ecc]);

semimajor = km2deg(4.338340);
ecc = axes2ecc(semimajor, km2deg(4.023916));
[lat2,lon2] = ellipse1(41.289937,129.038238,[semimajor ecc]);
p2 = geopointshape(41.289937,129.038238);

semimajor = km2deg(3.055475);
ecc = axes2ecc(semimajor, km2deg(2.320548));
[lat3,lon3] = ellipse1(41.304950,129.128556,[semimajor ecc]);
p3 = geopointshape(41.304950,129.128556);

semimajor = km2deg(3.221061);
ecc = axes2ecc(semimajor, km2deg(2.063787));
[lat4,lon4] = ellipse1(41.308235,129.064030,[semimajor ecc]);
p4 = geopointshape(41.308235,129.064030);

semimajor = km2deg(2.572024);
ecc = axes2ecc(semimajor, km2deg(2.216904));
[lat5,lon5] = ellipse1(41.294410,129.078681,[semimajor ecc]);
p5 = geopointshape(41.294410,129.078681);

semimajor = km2deg(2.215205);
ecc = axes2ecc(semimajor, km2deg(1.937707));
[lat6,lon6] = ellipse1(41.340298,129.047689,[semimajor ecc]);
p6 = geopointshape(41.340298,129.047689);


figure()
geobasemap satellite
hold on
geoplot(lat2,lon2,"LineWidth",2.5,"Color","g");
geoplot(p2.Latitude,p2.Longitude,"g+","LineWidth",2);
text(p2.Latitude+0.001,p2.Longitude-0.009,'Test 2',"Color","W",'FontSize',15);
geoplot(lat3,lon3,"LineWidth",2.5,"Color","b")
geoplot(p3.Latitude,p3.Longitude,"b+","LineWidth",2);
text(p3.Latitude+0.001,p3.Longitude+0.001,'Test 3',"Color","w",'FontSize',15);
geoplot(lat4,lon4,"LineWidth",2.5,"Color","r");
geoplot(p4.Latitude,p4.Longitude,"+r","LineWidth",2);
text(p4.Latitude+0.001,p4.Longitude+0.001,'Test 4',"Color","w",'FontSize',15);
geoplot(lat5,lon5,"LineWidth",2.5,"Color","c");
geoplot(p5.Latitude,p5.Longitude,"+c","LineWidth",2);
text(p5.Latitude+0.001,p5.Longitude-0.009,'Test 5',"Color","w",'FontSize',15);
geoplot(lat6,lon6,"LineWidth",2.5,"Color","m");
geoplot(p6.Latitude,p6.Longitude,"+m","LineWidth",2);
text(p6.Latitude+0.001,p6.Longitude+0.001,'Test 6',"Color","w",'FontSize',15);
title("DPRK Predicted Test Locations to 1\sigma");
axes('Position',[1,1,1,1])
box on
hold on

%%geoplot(p4.Latitude,p4.Longitude,"+r","LineWidth",1);



figure()
geobasemap topographic
hold on
geoplot(lat,lon,"LineWidth",2.5,"Color","b")
geoplot(p2.Latitude,p2.Longitude,"g+","LineWidth",1);
geoplot(p3.Latitude,p3.Longitude,"b+","LineWidth",1);
geoplot(p4.Latitude,p4.Longitude,"+r","LineWidth",1);
geoplot(p5.Latitude,p5.Longitude,"+c","LineWidth",1);
geoplot(p6.Latitude,p6.Longitude,"+m","LineWidth",1);
box on
geobasemap colorterrain
geoplot(lat,lon)
title("DPRK Predicted Test Site")


% Build Table Matrix
%Station count from Bayesloc Builder
% test = [2 3 4 5 6];
% testn = [37 84 80 90 126];
% Latsig = [4.338340 2.320548 2.063787 2.216904 1.937707];
% Longsig = [4.023916 3.055475 3.221061 2.572024 2.215205];
% Dtab(:,1) = test;
% Dtab(:,4) = testn;
% Dtab(:,2) = Latsig;
% Dtab(:,3) = Longsig;
% D = array2table(Dtab,"VariableNames",["Test","# of Stations Used","Lat \sigma [km]","Lon \sigma [km]"]);
% figure()
% uitable('Data',D{:,:},'ColumnName',D.Properties.VariableNames);





% 1 sigma SD

% Make Plot