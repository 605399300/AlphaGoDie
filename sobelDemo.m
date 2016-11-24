clc,clear,close all;
tic;
sourcePic=imread('others/ROI/DVD-R_new_ROI.jpg');%��ȡԭͼ��
figure,imshow(sourcePic);

% %%ѡȡ����Ȥ����
% h=imrect;%�����ʮ�֣�����ѡȡ����Ȥ����
% pos=getPosition(h);
% pic_ROI = imcrop( sourcePic, pos );
% imwrite(pic_ROI,'ROI_image/068_ROI.jpg');
% figure(2),imshow(pic_ROI);

%%  ת���ҶȳɻҶ�ͼ��
grayPic=rgb2gray(sourcePic);%ת���ɻҶ�ͼ��
figure,imshow(grayPic);
% grayPic=sourcePic;
%% ���⻯
% grayPic=histeq(grayPic,256);
% figure,imshow(grayPic);
%% ��Ƭ
grayPic=imadjust(grayPic,[0 1],[1 0]);%��Ƭ
figure,imshow(grayPic);
%%
% sourcePic=imadjust(sourcePic,[],[],1.6);%gama�仯
% figure,imshow(grayPic);
%%

[m,n]=size(grayPic);
%%
%grayPic=demo01;



% newGrayPic=grayPic;

dy = zeros(m,n);%y�����ݶ�  
d = zeros(m,n); 

gMax=0;gMin=255;%�����С�Ҷ�ֵ
%%
%         dx(i,j)=grayPic(i-1,j+1)+2*grayPic(i,j+1)+grayPic(i+1,j+1)-grayPic(i-1,j-1)...
%             -2*grayPic(i,j-1)-grayPic(i+1,j-1);%ˮƽ�����Ե
%%    3*3mask
    for i=2:m-1
        for j=2:n-1
     %%     0.5
            dy(i,j)=(0.5*grayPic(i-1,j-1)+grayPic(i-1,j)+0.5*grayPic(i-1,j+1)-...
                0.5*grayPic(i+1,j-1)-grayPic(i+1,j)-0.5*grayPic(i+1,j+1));%��ֱ�����Ե,3*3mask
   %%      1   
%               dy(i,j)=(grayPic(i-1,j-1)+2*grayPic(i-1,j)+grayPic(i-1,j+1)-...
%                 grayPic(i+1,j-1)-2*grayPic(i+1,j)-grayPic(i+1,j+1));%��ֱ�����Ե,3*3mask
%%   5*3mask
%     for i=3:m-2
%         for j=2:n-1
%             dy(i,j)=grayPic(i-2,j-1)+2*grayPic(i-2,j)+grayPic(i-2,j+1)-...
%                 grayPic(i+2,j-1)-2*grayPic(i+2,j)+grayPic(i+2,j+1);

%%    5*5mask
%         dy(i,j)=1*grayPic(i-2,j-2)+2*grayPic(i-2,j-1)+3*grayPic(i-2,j)+2*grayPic(i-2,j+1)+1*grayPic(i-2,j+2)...
%               -1*grayPic(i+2,j-2)-2*grayPic(i+2,j-1)-3*grayPic(i+2,j)-2*grayPic(i+2,j+1)-1*grayPic(i+2,j+2);
% %             +1*grayPic(i-1,j-2)+4*grayPic(i-1,j-1)+6*grayPic(i-1,j)+4*grayPic(i-1,j+1)+1*grayPic(i-1,j+2)...
% %             -1*grayPic(i+1,j-2)-4*grayPic(i+1,j-1)-6*grayPic(i+1,j)-4*grayPic(i+1,j+1)-1*grayPic(i+1,j+2);%5*5mask
%%
        d(i,j)=abs(dy(i,j));
        d(i,j)=floor(d(i,j))/2;
        if(gMax<d(i,j))
            gMax=d(i,j);
        end    
        if(gMin>d(i,j))
            gMin=d(i,j);
        end
%%    ����ֵ�����Ҷ�
%         d(i,j)=min(d(i,j),255);
%         if(d(i,j)>sobelThreshold)
%             newGrayPic(i,j)=d(i,j);
%         else
%             newGrayPic(i,j)=0;
%         end
        end
    end

%% ��ֵ��
 k=0.1;%��ֵ����ֵ
 binary=zeros(m,n);
 er=zeros(m,n);
 newGrayPic=grayPic;
    for i=2:m-1
        for j=2:n-1
            er(i,j)=(d(i,j)-gMin)/(gMax-gMin);
            if er(i,j)>0.1
                binary(i,j)=255;
            end
        end
    end
%% ���滯
% for i=2:m-1
%     for j=2:n-1
%        newGrayPic(i,j)=floor( ( (d(i,j)-gMin)/(gMax-gMin) ).*255 );
%     end
% end
%%
% figure,imhist(er,256);
% axis([0 1 0 5000]);
% figure,imshow(newGrayPic);

% imwrite(binary,'others/edge/DVD_end_ROI.jpg');
figure,imshow(binary);

% imwrite(binary,'others/edge/DVD_end_ROI_0.1binary.jpg');
% imwrite(binary,'others/edge/E-3F_ROI_0.1binary.jpg');
% imwrite(newGrayPic,'052_edge_3x3_0.5mask_Reverse.jpg');
% imwrite(newGrayPic,'021_reshape_edge_3x3_0.5mask.jpg');
% imwrite(newGrayPic,'021_edge_5x3mask.jpg');
% imwrite(newGrayPic,'021_edge_5x5mask.jpg');
% imwrite(newGrayPic,'052_edge_Reverse.jpg');
title('��Ե�����')
toc;
