

function [] = kalman_main()
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
      posi(:,:,i)=[mx my];

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

    kalman_ordem1(megamanPOSITION);
    kalman_ordem2(megamanPOSITION);
    drawnow;
    raio = 20;
    subplot(1,2,1);imshow(img);
    subplot(1,2,2);imshow(img(megamanPOSITION(2)-raio:megamanPOSITION(2)+raio,megamanPOSITION(1)-raio:megamanPOSITION(1)+raio,:));  
    
  %   imshow(img(megamanPOSITION(2)-raio:megamanPOSITION(2)+raio,megamanPOSITION(1)-raio:megamanPOSITION(1)+raio,:));  
  %  imshow(soma);
endfor
end

function [estados] = kalman_ordem1(z)
  
  disp(z)
  kq = 0.001;
  kr = 0.9;

  
  for i=1:101
    z(i, 1) = i + randn();
    z(i, 2) = i + randn();
  end
  
  %matriz de transiçao
  F = [1 1;
          1 1;];

  H = [1 0;
          0 1;];

  Q = eye(2)*kq;
  R = eye(2)*kr;
 
  P = zeros(2);

   estados(1, :)  = [z(1,1) z(1, 2)];
  
  for i=2:101
    [estados(i,:), P] = Kalman(estados(i-1,:), P, F, H, Q, R, z(i,:)');
  end


  %z e o ruido 
  %x e a correta 
  %xe e o estimado

  pl = plot(z(:,1), z(:,2), 'r.-', estados(:, 1), estados(:, 2), 'b.-'); 
  % waitfor(pl);
  
  % plot(1,101,xe(1,:),'-k',1,101,x,'-g',1,101,z,'-r');
  
end

function [] = kalman_ordem2(z)
   
  kq = 0.001;
  kr = 0.9;

  % z = []
  for i=1:101
    z(i, 1) = i + randn();
    z(i, 2) = i + randn();
  end
  
  %matriz de transiçao
  F = [1 1 0 0;
          0 1 0 0;
          0 0 1 1;
          0 0 0 1;];

  H = [1 0 0 0;
          0 0 1 0;];

  Q = eye(4)*kq;
  R = eye(2)*kr;
 
  P = zeros(4);

   estados(1, :)  = [z(1,1) 0 z(1, 2) 0];
  
  for i=2:101
    [estados(i,:), P] = Kalman(estados(i-1,:), P, F, H, Q, R, z(i,:)');
  end


  %z e o ruido 
  %x e a correta 
  %xe e o estimado

  pl = plot(z(:,1), z(:,2), 'r.-', estados(:, 1), estados(:, 3), 'b.-'); 
  % waitfor(pl);
  
  % plot(1,101,xe(1,:),'-k',1,101,x,'-g',1,101,z,'-r');
  
end

function [] = kalman_ordem3(z)
   
   
  kq = 0.001;
  kr = 0.9;

  
  for i=1:101
    z(i, 1) = i + randn();
    z(i, 2) = i + randn();
  end
  
  %matriz de transiçao
  F = [1 1 0 0 0 0;
         0 1 1 0 0 0;
         0 0 1 0 0 0;
         0 0 0 1 1 0;
         0 0 0 0 1 1;
         0 0 0 0 0 1;];

  H = [1 0 0 0 0 0;
          0 0 0 1 0 0;];

  Q = eye(6)*kq;
  R = eye(2)*kr;
 
  P = zeros(6);

 
  estados(1, :)  = [z(1,1) 0 0 z(1, 2) 0 0];
  
  for i=2:101
    [estados(i,:), P] = Kalman(estados(i-1,:), P, F, H, Q, R, z(i,:)');
  end


  %z e o ruido 
  %x e a correta 
  %xe e o estimado

  pl = plot(z(:,1), z(:,2), 'r.-', estados(:, 1), estados(:, 4), 'b.-'); 
  % waitfor(pl);
  
  % plot(1,101,xe(1,:),'-k',1,101,x,'-g',1,101,z,'-r');
  
end

function[x, P] = Kalman(x, P, F, H, Q, R, z)
  xa = F*x';                          % previsão a priori
  Pa = F*P*F' + Q;
  y = (z - H*xa);
  K = Pa*H'/(H*Pa*H' + R);
  x = xa + K*y;
  P = (eye(length(x)) - K*H)*Pa;
  x = x';
end