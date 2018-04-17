function ttask = timec_task(str,time)

%%%%%%%%%%%%%%% EQUIVALENT TO TTIM (ONATE, 2009) %%%%%%%%%%%%%%%%
%
%  INPUT
%    str   : name of the task 
%    time  : time to complete the task
%
%  OUTPUT
%    ttask : total time
%
% ...
   timetask = toc;
   fprintf('  %-35s %15.5e\n', str, timetask);
   ttask = timetask + time;
   
   tic

end