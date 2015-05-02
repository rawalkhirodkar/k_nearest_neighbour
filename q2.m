#! /usr/bin/octave -qf
clear
% question 2
warning ("off", "Octave:broadcast");

x = dlmread('trainr3.csv',',',"A1..C506"); %505 points in the training data set
y = dlmread('trainr3.csv',',',"D1..D506");

x1 = dlmread('testr30.csv',',',"A2..C101"); %100 points in the test data set 1
y1 = dlmread('testr30.csv',',',"D2..D101");

x2 = dlmread('testr31.csv',',',"A1..C95"); %95 points in the test data set 2
y2 = dlmread('testr31.csv',',',"D1..D95");


X = [x;x1];

X1 = X(1:505,:); %X1 is x, training dataset
x1 = X(506:605,:); %x1 is features data from testr30.csv

%calculating distances storing them in D1 matrix,sorting them,storing the indexes in I1 matrix
for i = 1:100
	v = X1 - x1(i,:);
	v = X1.^2;
	v = sum(X1,2);
	v = v.^(0.5);
	[s,j] = sort(v);
	D1(:,i) = s;
	I1(:,i) = j;
endfor

%loop to calculate labels for different values of k in KNN
for q = 1:500
	k = q; %k varies from 1 to 500

	D11 = resize(D1,k,100); %choosing k nearest points 
	I11 = resize(I1,k,100); %and there indexes

	y11 = zeros(100,1);

	for i = 1:100
		for j = 1:k
				y11(i,1) = y11(i,1) + y(I11(j,i));
		endfor
	endfor

	y11 = y11./k; %%average of k points
	y11 = round(y11); %% rounding off

	accuracy1(1,q) = sum(y11==y1)/100; % average accuracy
	K1(1,q) = k; %storing values of k for the plot
endfor

accuracy1 = accuracy1.*100;
plot(K1,accuracy1,'r');
xlabel('k');
ylabel('Accuracy for testr30.csv (%)');
axis([0,100,0,120]);
title "Test 1"
print plot2a.png;

clear X

X = [x;x2]; 

X2 = X(1:505,:);%X2 is x
x2 = X(506:600,:); %x2 is features data from testr31.csv

%calculating distances storing them in D2 matrix,sorting them,storing the indexes in I2 matrix
for i = 1:95 %95 datapoints
	v = X2 - x2(i,:);
	v = X2.^2;
	v = sum(X2,2);
	v = v.^(0.5);
	[s,j] = sort(v);
	D2(:,i) = s;
	I2(:,i) = j;
endfor

%loop to calculate labels for different values of k in KNN
for q = 1:500
	k = q;

	D22 = resize(D2,k,95); %choosing k nearest points 
	I22 = resize(I2,k,95);

	y22 = zeros(95,1);

	for i = 1:95
		for j = 1:k
				y22(i,1) = y22(i,1) + y(I22(j,i));
		endfor
	endfor

	y22 = y22./k; %%average of k points
	y22 = round(y22); %% rounding off

	accuracy2(1,q) = sum(y22==y2)/95; % average accuracy
	K2(1,q) = k; %storing values of k for the plot
endfor

accuracy2 = accuracy2.*100;
plot(K2,accuracy2,'r');
xlabel('k');
ylabel('Accuracy for testr31.csv (%)');
axis([0,100,0,120]);
title "Test 2"
print plot2b.png;

warning ("error", "Octave:broadcast");
