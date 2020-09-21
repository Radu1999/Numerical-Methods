function [Q, R] = Householder(A)
  [n, m] = size(A);
  Q = eye(n, n);
  sz = min(n, m);
  I = eye(n, n);
  for cnt = 1 : min(n - 1, m)
    v = zeros(1, cnt - 1);
    sigma = sign(A(cnt, cnt)) * norm(A(cnt : n, cnt));
    v(cnt) = A(cnt, cnt) + sigma;
    v((cnt + 1) : n) = A((cnt + 1) : n, cnt);
    if v * v' ~= 0
      H = I - 2 * v' * v ./ (v * v');   
      A = H * A; 
      Q = Q * H';
    endif
  endfor
  R = A;
  
endfunction