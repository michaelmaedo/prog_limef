function u = solve_lins(K, Fext, free)
%
%%%%%%%%%%%%%%%%%%%% SOLVE LINEAR SYSTEM %%%%%%%%%%%%%%%%%%%%%%%$
%
%  INPUT
%    K    : K-matrix
%    F    : global force vector
%    free : free nodes
%
%  OUTPUT
%    u    : nodal displacements
%
% ...

% Reverse Cuthil-Mckee Algorithm
  p = symrcm(K(free,free));

% 
  u(free(p)) = K(free(p),free(p))\Fext(free(p));
end