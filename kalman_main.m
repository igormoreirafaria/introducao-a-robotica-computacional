function [] = kalman_main()
  x =0:100;
  z = x + randn(1, 101);
  
  xe = [x(1);0]  
  P = (x(1) - z(1)) * (x(1) - z(1))';
  F = [1 1;0 1];
  H = [1 0];
  Q = [0 0;0 1]*0.1;
  R = 1;
  
  for i=2:101
    [xe(:,i), P] = Kalman(xe(:,i-1), P, F, H, Q, R, z(i));
  end
  %z e o ruido 
  %x e a correta 
  %xe e o estimado 
  plot(1,101,xe(1,:),'-k',1,101,x,'-g',1,101,z,'-r');
  
  
end


function[x, P] = Kalman(x, P, F, H, Q, R, z)
  xa = F*x;
  Pa = F*P*F' + Q;
  y = (z - H*xa);
  K = Pa*H'/(H*Pa*H' + R);
  x = xa + K*y;
  P = (eye(length(x)) - K*H)*Pa;
end

