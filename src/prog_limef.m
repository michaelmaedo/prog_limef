function nlife(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%% L I F E %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%  PURPOSE                                                      %
%    LIFE is a software for LInear Finite Element analysis.     %
%                                                               %
%  DETAILS                                                      %
%    Version: 1.7                                               %
%    Developer: Michael A. Maedo                                %
%    Last Update: 01-14-2015                                    %
%    Creation Date: 01-06-2015                                  %
%                                                               %
%  REFERENCES                                                   %
%    de Souza Neto, E. A., Peric, D., & Owen, D. R. J. (2011).  %
%    Computational   methods    for  plasticity:  theory   and  %
%    applications. John Wiley & Sons.                           %
%                                                               %
%    Fish, J.,  &  Belytschko, T.  (2007).  A first  course in  %
%    finite elements. John Wiley & Sons.                        %
%                                                               %
%    Onate, E. (2009). Structural  Analysis  with  the  Finite  %
%    Element  Method.  Linear  Statics:  Volume 1.  Basis  and  %
%    Solids. Springer Science & Business Media. Chicago	        %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  clear all;
  clc;
  format long;

% Add this path to allow access to m-files inside other folders
  p = fileparts(mfilename('fullpath'));
  addpath(genpath(p));  

% Greeting card
  greeting;

  switch nargin
%---------------------------------------------------------------%
    case 0                                                      %
%---------------------------------------------------------------%
% When the  present script is  called without  any argument,  the
% code opens a  window and ask the user  to select the  file that
% contains the inputs.

%---------------------------------------------------------------%
    case 1                                                      %
%---------------------------------------------------------------%
% However, if this script  is called with just one argument, this
% must contains the entire path of the file.
      [~,file,ext] = fileparts(varargin{1});
      file = [file,ext];

%---------------------------------------------------------------%
    case 2                                                      %
%---------------------------------------------------------------%
% On the other hand, if the script has received 2 arguments, then
% one argument must contain the path and the other one the file's
% name.
%      file = varargin{2};

%---------------------------------------------------------------%
    otherwise                                                   %
%---------------------------------------------------------------%
% In any other case, the program stops because it is not prepared
% to receive neither more than 2 arguments nor minus than 0.
      error('ANALYSIS: Incorrect number of arguments');

   end
   
% The uigetfile is only called if the file's name and the path of
% the file were not previously defined
  if ~exist('file','var')&&~exist('path_file','var')
      [file] = uigetfile('*.m','Define calc file');
  end
  
  tic;
  ttask = 0;
  
% Read and evaluate the data file (extension .m)
  file_name = strtok(file,'.m');
  eval(file_name);
  ttask = timec_task('Read and evaluate the data file', ttask);
  
% Start the analysis
%for i = 1 : 1000
  [u, R, S, T1, ttask] = linear_analysis(param, connec, xx, elset, force, displ, ttask);
%end
% Postprocess
  res2gid(file_name, param, connec, xx, u, R, S);
  ttask = timec_task('Write outputs in the data file', ttask);

  ttask = ttask + toc;
  [~] = timec_task('Total time', ttask);
  fprintf('\n');
end