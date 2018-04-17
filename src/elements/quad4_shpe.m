function [shape, dernat] = quad4_shpe(r, s)
%
%%%%%%%%%%%%%%%%% FOUR-NODE RECTANGULAR ELEMENT %%%%%%%%%%%%%%%%%
%
%                        s
%                        |
%                        |
%            (4) o---------------o (3)     Node    (r,s)
%                |       |       |         ----   -------
%                |       |       |           1    (-1,-1)
%                |       |       |           2    ( 1,-1)
%                |       +-------|---- r     3    ( 1, 1)
%                |               |           4    (-1, 1)
%                |               |
%                |               |
%            (1) o---------------o (2)
%
%  INPUT
%    r      : 1st local coord of gauss point in the parent domain
%    s      : 2nd local coord of gauss point in the parent domain
%
%  OUTPUT
%    shape  : Interpolate shape functions
%    dernat : Derivatives with respect to natural coordinates
%
% ...
% Shape functions
  shape(1) = 0.2500D+00*(1-r)*(1-s);
  shape(2) = 0.2500D+00*(1+r)*(1-s);
  shape(3) = 0.2500D+00*(1+r)*(1+s);
  shape(4) = 0.2500D+00*(1-r)*(1+s);

% Derivaties with respect to natural coordinates
  dernat(1,1) = -0.2500D+00*(1-s);
  dernat(1,2) =  0.2500D+00*(1-s);
  dernat(1,3) =  0.2500D+00*(1+s);
  dernat(1,4) = -0.2500D+00*(1+s);
  dernat(2,1) = -0.2500D+00*(1-r);
  dernat(2,2) = -0.2500D+00*(1+r);
  dernat(2,3) =  0.2500D+00*(1+r);
  dernat(2,4) =  0.2500D+00*(1-r);
  
end