function [cfx, cfy] = fit_widths_data(zs, wxs, wys, lamb)

    % Initial guess for parameters are to be a reasonable Gaussian beam focused through a 40cm lens
    p0 = [%...];

    % Parameters for fitting wys data
    wxs_array = %...% Double the wxs to match D4sigma 
    wys_array = %...% Double the wys 

    % Define objective function for wxs (x-direction)
    objective_function_x = @(p) sum((W(zs, p(1), p(2), p(3), lamb) - wxs_array).^2);

    % Perform fitting for wxs data
    [cfx, ~, ~, ~] = fminsearch(objective_function_x, p0);

    % Define objective function for wys (y-direction)
    objective_function_y = @(p) sum((W(zs, p(1), p(2), p(3), lamb) - wys_array).^2);

    % Perform fitting for wys data
    [cfy, ~, ~, ~] = fminsearch(objective_function_y, p0);
end