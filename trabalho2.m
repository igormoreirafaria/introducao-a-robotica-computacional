pkg load image;
pkg load geometry;

load('megaman.mat');
for o=1:100
  img = RGB{o};

  hsv_img = rgb2hsv (img);


  H = hsv_img(:,:,1);
  S = hsv_img(:,:,2);
  V = hsv_img(:,:,3);

  azul = (H >= 0.3 & H < 0.7 & V > 0.7 );
  laranja = (H <0.4 & V < 0.98 & V > 0.5 & S > 0.64);
  for i=1:3
      megaman(:,:,i) = azul.*img(:,:,i);
  endfor;

  
  BWmegamen = im2bw(megaman,0);
%  imshow(BWmegamen)
  %megamandilateimg = imdilate(BWmegamen, [1 1 1; 1 1 1 ; 1 1 1]);
  megamanclose = imclose(BWmegamen, ones(8));
%  imshow(megamanclose)
  mstat = regionprops(megamanclose,"Centroid");
%  megamanPOSITION = [];
%  if mstat
    
    mx = round(mstat.Centroid(1));
    my = round(mstat.Centroid(2));
  
    posMK(:,:,o)=[mx my];
    
    megamanPOSITION = [mx my];
%  endif
  for i=1:3
      vilao(:,:,i) = laranja.*img(:,:,i);
  endfor;
   %imshow(vilao);
  BWvilao = im2bw(vilao,0);
  
  %vilaodilateimg = imdilate(BWvilao, [1 1 1; 1 1 1 ; 1 1 1]);
  vilaoclose = imclose(BWvilao, ones(8));
  vstat = regionprops(vilaoclose,"Centroid");
  if vstat
    vx = round(vstat.Centroid(1));
    vy = round(vstat.Centroid(2));
    vilaoPOSITION = [vx vy];
  endif  

  soma = (megamanclose.*img) + (vilaoclose.*img);
%   soma = (megamanclose) + (vilaoclose);
%  imshow(soma)1
  disp(megamanPOSITION)
  drawnow;
  raio = 20;
  subplot(1,2,1);imshow(img);
  subplot(1,2,2);imshow(img(megamanPOSITION(2)-raio:megamanPOSITION(2)+raio,megamanPOSITION(1)-raio:megamanPOSITION(1)+raio,:));  
  
%   imshow(img(megamanPOSITION(2)-raio:megamanPOSITION(2)+raio,megamanPOSITION(1)-raio:megamanPOSITION(1)+raio,:));  
%  imshow(soma);
endfor

for i=1:100
  if i ==1
    dist_obj_rob(i)=sqrt((posMK(1,1,2)-posMK(1,1,1)).^2+ (posMK(1,2,2)-posMK(1,2,1)).^2); 
  else
    dist_obj_rob(i)=sqrt((posMK(1,1,i)-posMK(1,1,i-1)).^2+ (posMK(1,2,i)-posMK(1,2,i-1)).^2);
 endif
endfor

