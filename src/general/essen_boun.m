function [Fext, u, free, fix] = essen_boun(presc, nudof, k, fg)
%
%%%%%%%%%%%%%%%%%% ESSENCIAL BOUNDARY CONDITION %%%%%%%%%%%%%%%%%
%
%  INPUT
%    presc : Prescribed displacements
%    nudof : Degrees of freedom
%    k     : K-matrix
%    fg    : Global force vector
%
%  OUTPUT
%    Fext  : Updated force vector
%    u     : Nodal displacements
%    free  : Free nodes
%    fix   : Fixed nodes
%
% ...
% ...Memory Allocation...
  u   = zeros(nudof,1);            % nodal displacements
  fix = zeros(nnz(presc) - size(presc,1),1);  % fixed nodes

%------- Start loop over the fixed nodes -----------------------%
  for ifix = 1 : size(presc,1)                                  %
%---------------------------------------------------------------%

% Number of the node that has at least one prescribed DOF
    inode         = presc(ifix,1);

% Stores in u (nodal displacements) the prescribed displacements
    u(2*inode-1)  = presc(ifix,4);
    u(2*inode)    = presc(ifix,5);

% fix contains the prescribed DOF
    if (presc(ifix,2) == 1)
        fix(2*ifix-1) = 2*inode-1;
    end

    if (presc(ifix,3) == 1)
        fix(2*ifix)   = 2*inode;
    end
  end
%------- End loop ----------------------------------------------%

% Compute Fext with the prescribed values
  Fext = fg - k*u;

% Find the free nodes
  free = setdiff(1:nudof, fix);

end
