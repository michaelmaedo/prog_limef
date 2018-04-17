function S = strss_calc(param, connec, xx, elset, nodof, u)

%%%%%%%%%%%%%%%%%%% COMPUTE NODAL STRESSES %%%%%%%%%%%%%%%%%%%%%%
%
%  INPUT
%    param  : Control Parameters such as: nnode, nelem, etc.
%    connec : Global Connectivity of the System
%    xx     : Global Coordinates of the System
%    elset  : Element's Type and Material Properties
%    u      : Nodal displacements
%
%  OUTPUT
%    S      : Nodal Stresses
%
% ...
% ...Parameters...
  hypth = param.hypth;
  nnode = param.nnode;
  nelem = param.nelem;
  ngaus = param.ngaus;

% ...Number of stresses at each gauss point...
  if (hypth == 1) % Plane Stress
      nstrs = 3;
  else % Plane Strain or Axisymmetr.
      nstrs = 4;
  end

% ...Initialization...
  S     = zeros(nstrs,nnode);
  elpno = zeros(nnode,1);

%------- Start loop over the element ---------------------------%
  for ielem = 1 : nelem                                         %
%---------------------------------------------------------------%

% Extract informations of i-th element from connec and xx
    [inope, lnode, ix, iset] = extra_loca(ielem, connec, xx);

% Degrees of freedom of i-th element
    idof = inope*nodof;

% Determine local displacements
    ue = local_disp(inope, lnode, u);

% Compute stresses of i-th element
    sigma = strss_elem(hypth, inope, ix, idof, elset(iset,:), ...
                       nstrs, ue);

% Direct local extrapolation (Onate, 2009)
    eltyp = elset(iset,2); % Type of element
    ngpel = elset(iset,3); % Number of gauss point of i-th elem
    extrap = extra_func(eltyp,ngpel);

% Extrapolate to the nodes the stresses from the gauss points
    for istrs = 1 : nstrs      % loop over stresses
      for inode = 1 : inope    % loop over nodes/elem
          S(istrs,lnode(inode))  =  S(istrs,lnode(inode))   +  ...
                 sum(extrap(inode,1:ngpel).*sigma(istrs,1:ngpel));
      end
    end

% Number of elements that contain a certain node
    elpno(lnode) = elpno(lnode) + 1;

  end
%------- End loop ----------------------------------------------%

% Find mean stress at each node
  for inode = 1 : nnode
    S(1:nstrs,inode) =  S(1:nstrs,inode)/elpno(inode);
  end

end
