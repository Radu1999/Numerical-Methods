function [centroids] = clustering_pc(points, NC)
  [n, d] = size(points);
  cluster = zeros(NC, n);
  centroids = {};
  dims = zeros(NC);
  where = zeros(1, n);
  for i = 1 : n
    clst = mod(i, NC) + 1;
    cluster(clst, ++dims(clst)) = i;
    where(i) = clst;
  endfor
  for i = 1 : NC
    sum = 0;
    for j = 1 : dims(i)
      sum = sum + points(cluster(i, j), :);
    endfor
    if(dims(i) > 0)
      centroids = [centroids, sum ./ dims(i)];
    endif
  endfor
  new_list = zeros(NC, n);
  while 1
    ok = 0;
    dims = zeros(NC);
    for i = 1 : n
      min = 999999;
      ps = 0;
      for j = 1 : NC
        dist = norm(points(i, :) - centroids{j}, 2);
        if dist < min
          ps = j;
          min = dist;
        endif
      endfor
      
       if ps ~= where(i)
         ok = 1;
         where(i) = ps;
       endif
       new_list(ps, ++dims(ps)) = i;
        
      endfor
     if ok == 0
       ans = zeros(NC, d);
       for i = 1 : NC
         ans(i, :) = centroids{i};
       endfor
       centroids = ans;
       return;
     endif
     centroids = {};
     for i = 1 : NC
      sum = 0;
      for j = 1 : dims(i)
        sum = sum + points(new_list(i, j), :);
      endfor
      if(dims(i) > 0)
        centroids = [centroids, sum ./ dims(i)];
      endif
    endfor 
      
  endwhile
endfunction
