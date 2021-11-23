clc
clear all
close all
tic
Pic=cell(1,91);
for i=0:90
    Pic1=['D:\Books\Optic\LIF\LIF99\LIF99\C0= 2.5e-7\OutputPics\DSC_442000',num2str(i),'.jpg'];
    Pic{i+1}=rgb2gray(imread(Pic1));
%    Picdata(:,:,i+1)=(Picdata(:,:,1)+Picdata(:,:,2)+Picdata(:,:,3))/3;
end
%% First Task
% First Chart
    Task1=cell2mat(Pic);
for i=1:91
    Middle(i)=Task1(540,560+1920*(i-1));
end
figure(1)
plot(1:91,Middle)
xlabel('No. of pictures')
ylabel('Intensity of Middle pixle of pictures')
title('Middle picture intensity')
grid on
Av1=zeros(1080,1920);
Task1=double(Task1);
for i=1:91
    Av1=Av1+Task1(1:1080,1+1920*(i-1):1920*i);
end
Av1=Av1/91;
% % Second Chart
figure(2)
plot(Av1(:,960),1:1080)
xlabel('Intenssity')
ylabel('Pixels on X-Direction')
title('Variation of Intensity in X-Direction')
grid on
% Third chart
figure(3)
plot(1:1920,Av1(540,:))
xlabel('Pixels on Y-Direction')
ylabel('Intensity')
title('Variation of Intensity in Y-Direction')
grid on
%% Second Task
Task22=cell(1,3);
for i=0:2
    Task2=['D:\Books\Optic\LIF\LIF99\LIF99\C\OutputPics\DSC_44210',num2str(i),'.jpg'];
    Task22{i+1}=rgb2gray(imread(Task2));
end
    Task22=cell2mat(Task22);
for i=1:3
   for j=1:3
    Av2(:,:,j)=Task22(1:1080,1+1920*(i-1):1920+1920*(i-1));
    Av2=double(Av2);
    Av22(:,:,j)=Av2(:,:,j)./Av1;
end
end
figure(4)
imagesc(Av22(:,:,1))
colormap cool
colorbar
xlabel('Pixels on Y-Direction')
ylabel('Pixels on X-Direction')
title('First Picture for Density')

figure(5)
imagesc(Av22(:,:,2))
colormap cool
colorbar
xlabel('Pixels on Y-Direction')
ylabel('Pixels on X-Direction')
title('Second Picture for Density')

figure(6)
imagesc(Av22(:,:,3))
colormap cool
colorbar
xlabel('Pixels on Y-Direction')
ylabel('Pixels on X-Direction')
title('Third Picture for Density')

%% Third Task
Task3=cell(1,40);
for i=1:40
    Task3=['D:\Books\Optic\LIF\LIF99\LIF99\T=21\T=210',num2str(i),'.jpg'];
    Task33{i}=rgb2gray(imread(Task3));
end
Task33=cell2mat(Task33);
Av3=zeros(576,720);
Task33=double(Task33);
for i=1:40
    Av3=Av3+Task33(1:576,1+720*(i-1):720*i);
end
Av3=Av3/40;
Fourth Task
Task4=cell(1,40);
for i=1:40
    Task4=['D:\Books\Optic\LIF\LIF99\LIF99\T=53\T=530',num2str(i),'.jpg'];
    Task44{i}=rgb2gray(imread(Task4));
end
Task44=cell2mat(Task44);
Av4=zeros(576,720);
Task44=double(Task44);
for i=1:40
    Av4=Av4+Task44(1:576,1+720*(i-1):720*i);
end
Av4=Av4/40;
Temp1=21+273.15;
Temp2=53+273.15;
T=[21+273.15:0.01:53+273.15];
a=(Av4-Av3)/(Temp2-Temp1);
b=Av3-a*Temp1;
figure(7)
imagesc(a)
colormap cool
colorbar
xlabel('Pixels on Y-Direction')
ylabel('Pixels on X-Direction')
title('Contour of Parameter a')

figure(8)
imagesc(b)
colormap cool
colorbar
xlabel('Pixels on Y-Direction')
ylabel('Pixels on X-Direction')
title('Contour of Parameter b')

for i=1:4
Ilinear=a(i+171,2)*T+b(i+171,2);
figure(9)
plot(T,Ilinear)
xlabel('Pixels on Y-Direction')
ylabel('Pixels on X-Direction')
title('Linear Calibration of four pixels')
legend('First pixel','Second pixel','Third pixel','Fourth pixel')
hold on
grid on
end
Betha=-(log(Av4./Av3))/(1/(Temp1)-1/(Temp2));
figure(10)
imagesc(Betha)
colormap cool
colorbar
xlabel('Pixels on Y-Direction')
ylabel('Pixels on X-Direction')
title('Contour of Betha')
K=Av3.*exp(Betha/Temp1);
for i=1:4
    Iexp=K(i+171,2)*exp(Betha(i+171,2)./T);
    figure(11)
    plot(T,Iexp)
    xlabel('Pixels on Y-Direction')
    ylabel('Pixels on X-Direction')
    title('Exponential Calibration of four pixels')
    legend('First pixel','Second pixel','Third pixel','Fourth pixel')
    hold on
    grid on
end
I1=a(172,2)*T+b(172,2);
I2=K(172,2)*exp(Betha(172,2)./T);
figure(12)
plot(T,I1,T,I2)
xlabel('Temperature')
ylabel('Intensity')
title('Exponential & Linear Calibration of a pixel')
legend('Linear Calibration','Exponential Calibration')
ylim([0 2])
grid on
%% Fifth Task
Task5=rgb2gray(imread('D:\Books\Optic\LIF\LIF99\LIF99\T\T 277.jpg'));
Task5=double(Task5);
Tlinear2=(Task5-b)/a
figure(13)
imagesc(Tlinear2)
colorbar('YTick',0,'YTickLabel',50)
colormap cool
xlabel('Pixels on Y-Direction')
ylabel('Pixels on X-Direction')
title('Linear Caclibration of a picture of File T')
Texp2=Betha./log(Task5./K)
figure(14)
imagesc(Texp2)
colorbar('YTick',0,'YTickLabel',50)
colormap cool
xlabel('Pixels on Y-Direction')
ylabel('Pixels on X-Direction')
title('Exponential Caclibration of a picture of File T')
for i=1:4
    T4(i)=(Task5(i+171,2)-b(i+171,2))/a(i+171,2);
    T5(i)=Betha(i+171,2)/log(Task5(i+171,2)/K(i+171,2));
end
%% Sixth Task
Task6=cell(1,21);
for i=0:20
    Task6=['D:\Books\Optic\LIF\LIF99\LIF99\background for concentration\OutputPics\DSC_44330',num2str(i),'.jpg'];
    Task66{i+1}=rgb2gray(imread(Task6));
end
Task66=cell2mat(Task66);
Av6=zeros(1080,1920);
Task66=double(Task66);
for i=1:21
    Av6=Av6+Task66(1:1080,1+1920*(i-1):1920*i);
end
Av6=Av6/21;
Av11=Av1-Av6;
figure(15)
imagesc(Av11)
colormap cool
colorbar
xlabel('Pixels on Y-Direction')
ylabel('Pixels on X-Direction')
title('Density with subtraction of background')
toc
