function [u, R, S, T1, ttask] = linear_analysis(param, connec, xx,...
                            elset, force, displ, timet)

%%%%%%%%%%%%%%%%%%%%%%%% START ANALYSIS %%%%%%%%%%%%%%%%%%%%%%%%%
%
%  INPUTS
%    param   : Control Parameters such as: nnode, nelem, etc.
%    connec  : Global Connectivity of the System
%    xx      : Global Coordinates of the System
%    elset   : Element's Type and Material Properties
%    naturbc : Natural Boundary Conditions
%    essenbc : Essencial Boundary Conditions
%
% ...
% ...Parameters...
  hypth = param.hypth; % hypothesis adopted
  nnode = param.nnode; % number of nodes
  nelem = param.nelem; % number of elements
  nodof = 2;           % number of degree of freedom per node
  nudof = nnode*nodof; % number of degrees of freedom

% ...Initialize variables...
  ntriplet = 0;                  % number of triplets
  nonzeros = 6*nelem;            % number of nonzeros in K-matx
  Fext     = zeros(nudof,1);     % global force vector
  R        = zeros(nudof,1);     % reactions on the fixed nodes
  row      = zeros(nonzeros,1);  % it contains row pos. of Kg
  col      = zeros(nonzeros,1);  % it contains column pos of Kg
  Kg       = zeros(nonzeros,1);  % it contains nonzeros of K-matx

  ttask = timet;
%------- Start loop over the element ---------------------------%
  for ielem = 1 : nelem                                         %
%---------------------------------------------------------------%

% Extract informations of i-th element from connec and xx
    [inope, lnode, ix, iset] = extra_loca(ielem, connec, xx);

% Degrees of freedom of the element
    idof = inope*nodof;

% Compute K and F of the element
    [Ke, Fe] = Kelem_matx(hypth, inope, ix, idof, elset(iset,:));

 % Assemble Fe and Ke into Fext and K-matrix
    gdof = zeros(idof,1);
    for inode = 1 : inope
      gdof(nodof*inode - 1) = nodof*lnode(inode) - 1;
      gdof(nodof*inode)     = nodof*lnode(inode);
    end

    for ii = 1 : idof
      Fext(gdof(ii)) = Fext(gdof(ii)) + Fe(ii);
      for jj = 1 : idof
         ntriplet      = ntriplet + 1;
         row(ntriplet) = gdof(ii);
         col(ntriplet) = gdof(jj);
         Kg(ntriplet)  = Ke(ii,jj);
      end
    end
  end
%------- End loop ----------------------------------------------%

% Construct sparse K-matrix from row, col, Kg and nudof
  K = sparse(row, col, Kg, nudof, nudof);
  T1 = K;
  ttask = timec_task('Assemble K-matx', ttask);

% Natural bondary conditions (Neumann)
  [Fext] = natur_boun(hypth, xx, elset(1,:), force, Fext);
  ttask = timec_task('Natural boundary conditions', ttask);
  
% Essential boundary conditions (Dirichlet)
  [Fext, u, free, fix] = essen_boun(displ, nudof, K, Fext);
  ttask = timec_task('Essential boundary conditions', ttask);
  
% Reverse Cuthil-Mckee Algorithm
  p = symrcm(K(free,free));
  ttask = timec_task('Cuthil-McKee to reorganize K', ttask);

% Solve linear system
  u(free(p)) = K(free(p),free(p))\Fext(free(p));
  ttask = timec_task('Solve the linear system F = K*u', ttask);

% Compute reactions on the fixed nodes
  R(fix) = K(fix,1:nudof)*u(1:nudof) + Fext(fix);
  ttask = timec_task('Compute reactions on fixed nodes', ttask);

% Compute nodal stresses
  S = strss_calc(param, connec, xx, elset, nodof, u);
  ttask = timec_task('Compute nodal stresses', ttask);
  
end