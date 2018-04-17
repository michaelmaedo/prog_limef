%%%%%%%% Hypothesis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%   1 = Plane Stress                                            %
%   2 = Plane Strain                                            %
%   3 = Axisymmetric                                            %
%   4 = 3D Analysis                                             %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param.hypth = 1;
%------- Control Parameters ------------------------------------%
param.nnode = 8; % number of nodes
param.nelem = 6; % number of elements
param.nsets = 1;   % number of sets
param.nintr = 1;   % number of intervals
param.nnope = 3;   % max number of nodes per element
param.ngaus = 1;   % max number of gauss point
%------- Connectivity ------------------------------------------%
connec = [
    1      1      6     4     2
    2      1      2     5     6
    3      1      7     3     1
    4      1      1     8     7
    5      1      4     7     8
    6      1      8     2     4
];
%------- Nodal Coordinates -------------------------------------%
xx = [
    1            400.01000           200.00000
    2            200.00000           200.00000
    3            400.01000             0.00000
    4            200.00000             0.00000
    5              0.00000           200.00000
    6              0.00000             0.00000
    7            200.01000             0.00000
    8            200.01000           200.00000
];
%%%%%%%% SETS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%  elset(iset,1) - Model                                        %
%    0 = Linear Elastic Model                                   %
%                                                               %
%  elset(iset,2) - Element's type                               %
%    1 = Linear Rod Element                                     %
%    2 = Quadratic Rod Element                                  %
%    3 = Linear Triangles                                       %
%    4 = Quadratic Triangles                                    %
%    5 = Linear Rectangles                                      %
%    6 = Quadratic Rectangles                                   %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elset(1,1) = 0;     % model
elset(1,2) = 3;     % type of the element
elset(1,3) = 1;     % number of gauss points of the element
elset(1,4) = 28000; % young modulus
elset(1,5) = 0.20;  % poisson's ratio
elset(1,6) = 200;   % thickness
elset(1,7) = 0;     % density
%------- Essencial Boundary Condition --------------------------%
displ = [
     5  1  1  0.000000 0.000000
     6  1  0  0.000000 0.000000
];
%%%%%%%% Natural Boundary Condition %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%  naturbc.point - Applied directly to the node                 %
%  naturbc.face  - Applied to the face of the element           %
%  naturbc.body  - Applied to the body                          %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
force.point = [
    1   13.0   0.0
    3   13.0   0.0
];

force.face(:,:,1) = [
      1    3    0   0   0   0
];
