function [hno,hr0,hra]=Target_height(m,h,frr,f)
%==========================================================================
%本函数是用来计算表4的最后一列
%输入的发光点离照相机距离及离主光轴高度(m,h),焦比frr,焦距f
%输出的是发光点发出的射线交焦平面的高度信息(mm)，分别为小孔成像的高度hno,射向凸
%透镜左凸点的光线经折射后与焦平面交点的高度，射向凸透镜光心的射线经折射后与焦平
%面的交点高度
%创建人：毛家发
%创建时间：2021-11-3
%完成时间：
%==========================================================================
r=f/frr;%光圈值
n=Refractive_index(f,r);%凸透镜的折射率
%==========================================================================
%下面一段程序段是射向光心的射线折射角求法
afai_1=atan(h/m);%射向光心的角度,也是入射点
x_1=Mapping_d2r(afai_1,r);%与Angular_offset(sat,afai,n)对应的入射点
afai_11=atan((h-x_1)/m);%角度仿射变换
%sat_1=Normal_vector(afai_11,f,r,n);%afai_1点的法方向
ra_1=Angular_offset_NSNP(afai_11,afai_1,n,r,f);%经凸透镜折射后得到的射线与主光轴的夹角
%==========================================================================
%下面一段程序是用来计算比射向光心射线R_{afai_1}^{0}的折射角求法
x_2=0;%入射点为0；
afai_2=afai_1;%入射角为atan(h/m)
ra_2=Angular_offset_NSNP(afai_2,x_2,n,r,f);%经凸透镜折射后得到的射线与主光轴的夹角
%=========================================================================
%下面一段程序是用来画凸透镜左边的射线
k_ra_0=-1*tan(afai_1);%小孔成像的斜率

k_1=(h-x_1)/m;%发光点射线的斜率
k_ra_1=tan(ra_1);%折射线的斜率

k_2=(h-x_2)/m;%入射点0射线的斜率
k_ra_2=tan(ra_2);%入射点0射线的折射线的斜率

hno=k_ra_0*f;%小孔成像原理（即不发生折射）与焦平面交点高度
hr0=-1*k_ra_2*f+x_2;%左凸点的光线经折射后与焦平面交点的高度
hra=-1*k_ra_1*f+x_1;%射向光心的射线经折射后与焦平面的交点高度


