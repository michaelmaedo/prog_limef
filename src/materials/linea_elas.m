function [C, t] = linea_elas(hypth, E, v, thick, xx_gausp)
%
%%%%%%%%%% COMPUTE LINEAR ELASTIC CONSTITUTIVE MATRIX %%%%%%%%%%%
%
%  INPUTS
%    E        : Young Modulus
%    v        : Poisson's ratio
%    thick    : Thickness
%    xx_gausp : Coordinate of Gauss Point
%
%  OUTPUTS
%    C        : Linear Elastic Constitutive Matrix
%    t        : Thickness
%
%...
  switch (hypth)
%  
%------- Plane stress ------------------------------------------%
    case 1                                                      %
%---------------------------------------------------------------%
%
%           E   [1    v      0   ]
%  C = ---------[v    1      0   ]
%      (1 - v^2)[0    0   (1-v)/2]
%
      C      = zeros(3,3);
      C(1,1) = 1;
      C(2,2) = 1;
      C(1,2) = v;
      C(2,1) = v;
      C(3,3) = (1-v)/2;
      C      = E/(1-v^2)*C;
% ...Thickness...
      t = thick;


%------- Plane strain ------------------------------------------%
    case (2)                                                    %
%---------------------------------------------------------------%
%
%            E      [1-v   v       0     ]
%  C = -------------[ v   1-v      0     ]
%      (1-v)*(1-2*v)[ 0    0    (1-2*v)/2]
%
      C      = zeros(3,3);
      C(1,1) = 1-v;
      C(2,2) = 1-v;
      C(1,2) = v;
      C(2,1) = v;
      C(3,3) = (1-2*v)/2;
      C      = E/((1+v)*(1-2*v))*C;
% ...Thickness...
      t = 1;


%------- Axisymmetric ------------------------------------------%
    case (3)                                                    %
%---------------------------------------------------------------%
%
%            E      [1-v   v    v       0    ]
%  C = -------------[ v   1-v   v       0    ]
%      (1-v)*(1-2*v)[ v    v   1-v      0    ]
%                   [ 0    0    0   (1-2*v)/2]
%
    C      = zeros(4,4);
    C(1,1) = 1-v;
    C(2,2) = 1-v;
    C(3,3) = 1-v;
    C(1,2) = v;
    C(1,3) = v;
    C(2,1) = v;
    C(2,3) = v;
    C(3,1) = v;
    C(3,2) = v;
    C(4,4) = (1-2*v)/2;
    C      = E/((1+v)*(1-2*v))*C;
% ...Thickness...
    t = 2*pi*xx_gausp;


%------- In any other case -------------------------------------%
    otherwise                                                   %
%---------------------------------------------------------------%
      error('const_matx: invalid data in hypth');
  end
end