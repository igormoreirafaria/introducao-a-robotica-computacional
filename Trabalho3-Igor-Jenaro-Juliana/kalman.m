function[x, P] = Kalman(x, P, F, H, Q, R, z)
  xa = F*x;
  Pa = F*P*F' + Q;
  y = (z - H*xa);
  K = Pa*H'/(H*Pa*H' + R);
  x = xa + K*y;
  P = (eye(length(x)) - K*H)*Pa;
end

