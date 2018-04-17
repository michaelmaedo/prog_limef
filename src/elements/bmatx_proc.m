function [B] = bmatx_proc(hypth, inope, idof, shape, dernat,  ...
                          xx_gausp, invJ)
%
%%%%%%%%%%%%%%%%% COMPUTE B-MATRIX OF I-ELEMENT %%%%%%%%%%%%%%%%%
%
%  INPUT
%    hypth    : Hypothesis assumed (Plane Stress, Plane Strain, etc)
%    inope    : Number of nodes of i-element
%    idof     : Degrees of freedom of i-element
%    shape    : Shape function of i-element
%    dernat   : Derivatives with respect to natural coordinates
%    xx_gausp : Coordinates of gauss point
%    invJ     : Inverse of Jacobian Matrix
%
%  OUTPUT
%    B        : B-matrix of i-element
%
%...

%------- Plane Stress or Plane Strain --------------------------%
  if (hypth == 1 || hypth == 2)                                 %
%---------------------------------------------------------------%
% ...Initialize B...
    B = zeros(3,idof);
    for inode = 1 : inope

% Find derivatives with respect to cartesian coordinates
      deriv_xx(1) = invJ(1,1)*dernat(1,inode)+invJ(1,2)*dernat(2,inode);
      deriv_xx(2) = invJ(2,1)*dernat(1,inode)+invJ(2,2)*dernat(2,inode);

% Construct B-matrix
      B(1,2*inode-1) = deriv_xx(1);
      B(2,2*inode)   = deriv_xx(2);
      B(3,2*inode-1) = deriv_xx(2);
      B(3,2*inode)   = deriv_xx(1);
    end


%------- Axisymmetric ------------------------------------------%
  elseif (hypth == 4)                                           %
%---------------------------------------------------------------%

% ...Initialize B...
    B = zeros(4,idof);
    for inode = 1 : inope

% Find derivatives with respect to cartesian coordinates
      deriv_xx(1) = invJ(1,1)*dernat(1,inode)+invJ(1,2)*dernat(2,inode);
      deriv_xx(2) = invJ(2,1)*dernat(1,inode)+invJ(2,2)*dernat(2,inode);

% Construct B-matrix
      B(1,2*inode-1) = deriv_xx(1);
      B(2,2*inode)   = deriv_xx(2);
      B(3,2*inode-1) = shape(inode)/xx_gausp(1);
      B(4,2*inode-1) = deriv_xx(2);
      B(4,2*inode)   = deriv_xx(1);
    end

%------- In any other case -------------------------------------%
  else                                                          %
%---------------------------------------------------------------%
    disp('bmatx_proc: invalid data in hypth');
  end
end