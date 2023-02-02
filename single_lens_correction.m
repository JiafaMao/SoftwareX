function[Bc_x,Bc_y]=single_lens_correction(B_x,B_y)
%==========================================================================
%本函数为华为荣耀相机的畸变校正接口函数
%输入的是待校正点B在像平面的坐标(B_x,B_y)（像素）
%输出的是校正后点Bc在像平面上的坐标(Bc_x,Bc_y)（像素）
%创建人：毛家发
%创建单位：浙江工业大学计算机科学与技术学院
%创建时间：2022年5月1号
%==========================================================================
%下面代码是一些固定参数
M=5120;N=3840;%图像尺寸
l=30.72;w=23.04;%CMOS或CCD大小
f=4;ef=27;%焦距与等效焦距
n_1=1.48;%凸透镜材质的折射率
k=Focal_radius_ration(n_1);%焦比
n=1/sin(atan(k));%折射率
%==========================================================================
B_u=(B_x-M/2)*l/M;B_v=(B_y-N/2)*w/N;%像点B在CMOS的坐标(mm)
%Seita=atan(abs(B_v)/abs(B_u));%OB点与u轴夹角
if(B_u==0 & B_v==0)
    Seita=0;
elseif(B_u==0 & B_v~=0)
    Seita=pi/2;
else
    Seita=atan(abs(B_v)/abs(B_u));%OB点与u轴夹角
end
OB=sqrt(B_u*B_u+B_v*B_v);%B点到CMOS中心的距离
Beita=atan(OB/ef);%折射角
Afa=asin(n*sin(Beita));%入射角
d=ef*tan(Afa);%校正点Bc离CMOS中心距离
Bc_u=sign(B_u)*d*cos(Seita);
Bc_v=sign(B_v)*d*sin(Seita);%校正点Bc在CMOS的坐标(Bc_u,Bc_v)
Bc_x=round(Bc_u*M/l+M/2);
Bc_y=round(Bc_v*N/w+N/2);%校正点Bc在像平面的坐标(Bc_x,Bc_y)