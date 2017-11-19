%MTplot
%
%Moment Tensor Plotting
%
% 2014 David J Pugh, Bullard Labs, University of Cambridge and Schlumberger
% Cambridge Research (Version 1.0)
%
% Syntax
% 
% MTplot(MT)
% MTplot(MT,mode) 
% MTplot(MT,mode,stations) 
% MTplot(...,'PropertyName',PropertyValue) 
%
% Description
%
% The input moment tensor can be either [strike,dip,rake],
% [Mxx,Myy,Mzz,sqrt(2)*Mxy,sqrt(2)*Mxz,sqrt(2)*Myz] or the full Moment Tensor:
% [Mxx,Mxy,Mxz;Myx,Myy,Myz;Mzx,Mzy,Mzz]. To plot multiple moment tensors
% the input should be a cell array of the moment tensors as above i.e.
% {[strike,dip,rake],[strike,dip,rake]}, or an array of 6 by n MT six
% vectors. Mixing the formats is ok. For more information see <a href="matlab:doc MTcheck;">MTcheck</a>
% 
% Required Modules: <a
% href="http://www.mathworks.co.uk/matlabcentral/fileexchange/20003-panel">Panel</a>, <a
% href="http://www.mathworks.co.uk/matlabcentral/fileexchange/7943-freezecolors---unfreezecolors">freezeColors</a>,MTcheck
% (in the complete Moment Tensor module)
% 
% 
%
% MTplot(MT) creates a Equal Area lower hemisphere projection plot of the
% moment Tensor MT.
%
% MTplot(MT,mode) plots the moment tensor according to the specified mode.
% Allowed modes are:
%                   beachball [default]
%                   radiation
%                   riedeseljordan
%                   hudson
%                   faultplane
%                   tnp
%                   lune
%                   component
%                   eigenvalues
%                   tape
%                   orientation
%                   sdr
%                   sdrsilhouette
%                   3dlocation
%                   hx (Equal area source type)
%
%
% MTplot(MT,mode,stations) plots the moment tensor as above, adding (where
% possible) the station information and polarities. The stations must be
% specified as a cell array: {Name,Azimuth,ToA,Polarity} where the polarity
% is positive - upwards triangles, negative downwards triangles and zero is
% a circle (no information).
%   E.g.
%   {'ASK',123,56,1;'BAR',246,76,0;'MIL',11,5,-1}
%
% MTplot(...,'PropertyName',PropertyValue) plots as above, but with certain
% properties being adjusted from their defaults. The editable properties
% and their defaults are:
%   'Projection':'EqualArea'
%   'ProjectionAxis':[]
%   'Dimension':'2d'
%   'Lower':true
%   'FullSphere':false
%   'Phase':'P'
%   'Logarithm':false
%   'Superposition':false
%   'Presentation':false
%   'StationMarkerSize':8
%   'StationProjection':true
%   'StationDistribution':{}
%   'PolarityErrorHighlight':false
%   'Radians':false
%   'Colormap':'Clear'
%   'PT':true
%   'FP':false
%   'BA':false
%   'MaxSource':false
%   'Contour':false
%   'Probability':[]
%   'Marginalised':true
%   'Resolution':300
%   'WindowTitle':''
%   'Subtitle':false
%   'Roman':false
%   'AxisTitle':false
%   'AxisLines':true
%   'Text':true
%   'AxisLabel':true
%   'TypeLabel':false
%   'Marker':'o'
%   'MarkerSize':6
%   'C':[3,1,1,0,0,0,...
%          3,1,0,0,0,...
%            3,0,0,0,...
%              1,0,0,...
%                1,0,...
%                  1]
%   'FigureHandle':0
%   'Panel':false
%   'FontSize':12
%   'LineWidth':1
%   'Color':'b'
%   'Legend':false
%   'Names':{}
%   'Chain':false
%   'Movie':false
%   'R':6371
%   'Locations':[]
%   'LocationUnits':'latlon'
%   'Samples':0
%   'Interp':0
%   'InteriorLines':true
%   'Scale':false
%
% 
% Properties
%
%   'Projection':2 dimensional projection functions: 'EqualAngle','EqualArea','u-v','tau-k' - The latter are
%       for Hudson plots
%   'ProjectionAxis':Array =    
%   'Dimension':Plotting dimension (if available): '2d', '3d', 'default'
%   'Lower':Boolean - For 2d projections, whether to do a lower or upper
%       hemisphere projection.
%   'FullSphere':Boolean - Plot the full sphere or just the inner hemisphere
%   'Phase':Char - select phase from 'P','S','SH','SV','P/S','P/SH','P/SV','SH/SV'
%   'Logarithm':Boolean - set logarithm for amplitude and amplitude ratio
%       calculations, and probability plots.
%   'Superposition':Boolean - show event superposition, requires location
%       option.
%   'Presentation':Boolean - plot in presentation mode (large stations and
%       no names) or not
%   'StationMarkerSize':Numeric - station marker plot size.
%   'StationProjection':Boolean - Project Stations from non plotted
%       hemisphere in beachball plots.
%   'StationDistribution':Struct - Station Distribution from MTINV output
%       (struct containing Distribution and Probability Attributes - Cell
%       struct of stations and numeric array respectively.)
%   'PolarityErrorHighlight':Boolean - Highlight 'incorrect' station polarities.
%   'Radians': Boolean - station angles are in radians
%   'Colormap':'Clear', 'BlueRed' (Has high contrast between positive and negative) or
%       the standard <a href="matlab: doc colormap;">colormaps</a>
%   'PT':Boolean - whether to plot TNP axes and Fault Plane 
%       normals or not
%   'FP':Boolean - plot the fault planes on the plot.
%   'BA':Boolean - plot the bi-axes faultplane and slip plane on the plot
%       instead of the fault planes
%   'MaxSource':Boolean - plot max probability source on hudson plot
%       instead of PDF
%   'Contour':Boolean/numeric - plot contours if numeric and hudson or lune
%       selected, plots the probability contour for that value.
%   'Probability':Array - array of probability values for the given MTs, used in
%       FocalPlane2dProb, FocalPlaneProb,TNP2dProb and TNPProb
%   'Marginalised': Plots marginalised PDFs for PDF type plots, if false
%       plots the max value prob for each bin.%   'AxisLabel':true
%   'Resolution':Integer - the number of points to use in the generation of
%       the figure.
%   'WindowTitle':String - Plot window title
%   'Subtitle':String or Cell-Array- plot subtitles - array for panel plot, if
%       false, standard character labels are used in panel plot
%   'Roman':Boolean - use roman numerals in panel plot when fewer than 26 panels
%   'AxisTitle':Boolean - show axis title
%   'AxisLines':Boolean - show north/east lines, show prior distribution in Tape
%       parameters plots
%   'AxisLabel':Boolean - show axis labels.
%   'Text':Boolean - enable/disable all plot text except Axis Labels (i.e. T,N,P axes, North and East axes
%       markers and station labels.
%   'TypeLabel': Boolean - Shows the source type positions on the plot.
%   'Marker':Char - Marker type for Hudson and lune type plots. (from
%       <a href="matlab: doc plot">default matlab styles</a>.
%   'MarkerSize':Numeric - Marker size.
%   'C':Array describing the upper triangular part of the anisotropy tensor.
%   'FigureHandle':Handle - handle to existing figure to use.
%   'Panel':Boolean - uses panel to do multiplots, each cell of MTs/stations is plotted
%       into a panel with the specified geometries in the MT cell
%   'FontSize':Numeric - Font size
%   'LineWidth':Numeric - Line width.
%   'Color':Char or rgb array describing marker colours for hudson and lune
%       type plots.
%   'Legend':Boolean - Show a legend for hudson and lune type plots.
%   'Chain': Boolean - Plots the McMC chain if lune is selected.
%   'Movie': Boolean - Plots the McMC chain as a movie if Chain and lune is selected.
%   'R':Numeric - Radius in km to use for locations conversion.
%   'Locations':Array - event locations for each moment Tensor - expect Lat,
%       Lon, Depth or N,E,Depth. Unit type (km/latlon) specified using
%       'LocationUnits'
%   'LocationUnits':'km' or 'latlon' - specifies location unit types for
%       conversions
%   'Samples':Numeric - number of samples to plot (useful for e.g.
%       faultplane plots as large numbers of lines plotted can be very
%       slow) defaults is to plot all samples (0)
%   'Interp':Boolean - use Facecolor interpolation or not on surface plots.
%   'InteriorLines':Boolean - plot interior dashed lines on hudson and lune plots.
%   'Coordinate':Char - name of coordinate to use for coordinate plot
%   (default=g)
%   'Normalise': Boolean - normalise the probability plot for histogram
%   based plots.
%   'Scale': Boolean - scale probabilities to max P for all events(Fault plane plots)
%
%
% 
% 
%


%Main Function
function [h,options]=MTplot(MT,varargin)
    global plot_types
    plot_types={'radiation',...
               'beachball',...
               'faultplane',...
               'riedeseljordan',...
               'hudson',...
               'lune',...
               'tape',...
               'orientation',...
               'tnp',...
               'sdr',...
               'sdrsilhouette',...
               'component',...
               'eigenvalues',...
               '3dlocation',...
               'coordinate',...
               'hx'};
try
           [options]=Parser(MT,varargin{:});
catch ME
    if strcmpi(ME.message,'Not enough input arguments.')
        help MTplot
    end
    ME.rethrow()
end
    options=parse_options(options);
    if options.PanelMode && numel(options.PanelIndex)==2&&~iscell(options.Mode) && ~any(strcmpi(options.Mode,{'sdr','sdrsilhouette','orientation','tape'}))
        i=options.PanelIndex(1);
        j=options.PanelIndex(2);
        p=panel.recover();
        p(i,j).select();
    end
    MT=options.MT;    
    [MT,options]=sample_check(MT,options);
    if options.FigureHandle>0 ||isa(options.FigureHandle,'matlab.ui.Figure')
        h=figure(options.FigureHandle);
    else
        h=figure('NumberTitle','off','Name',[options.WindowTitle,options.TitleFn(options)]);
    end
    if ~feature('ShowFigureWindows')
        set(h,'visible','off')
%             close; %NOTE: In MATLAB 6.5 (R13) there is an issue with headless printing, i.e., 
%                    %when the DISPLAY is unset, which causes the PS file to be created without any plot in it. 
%                    %In order to create "file.ps" that contains a plot you need to add the commands "figure;close" before the PLOT statement:
%             h=gcf;
    end
    options.PlotFn(MT,h,options);
    options.BackgroundFn(MT,h,options);
    set(h,'Color','w');
end
%Parser
function output=validate_modes(mode,check)
if nargin<2
    check=false;
end
if iscell(mode)
    if ~check
        output=true;
    else
        output=mode;
    end
    return
end
if ~ischar(mode)
    error('MTplot:type_check',['Plot type ',mode,'not recognised, must be cell array or char from ',strjoin(plot_types,'\n')]);
end
mode=strrep(mode,'-','');
mode=strrep(mode,' ','');
mode=lower(mode);
valid=false;
global plot_types
if any(strcmpi(mode,plot_types))
    valid=true;
end
if ~check
    if ~valid
        error('MTplot:type_check',['Plot type "',mode,'" not recognised, must be cell array or char from:\n\t',[plot_types{1} sprintf('\n\t%s', plot_types{2:end})]]);
    end
    output=valid;
elseif valid
    output=mode;
else
    error('MTplot:type_check',['Plot type ',mode,'not recognised, must be cell array or char from \n',[plot_types{1} sprintf('\n%s', plot_types{2:end})]])
end
end
function output=validate_dimensions(dim,mode,panel)
    default_2d={'radiation','beachball','faultplane','riedeseljordan','lune','tnp'};
    default_3d={};
    fixed_dim={'3dlocation','hudson','tape','orientation','sdr','sdrsilhouette','component','eigenvalues','hx','coordinate'};
    if iscell(mode)||panel
        output=dim;
        return
    end
    if ~ischar(dim)||~any(strcmpi(dim,{'2d','3d','default'}))
        error('MTplot:type_check',['Dimension ',dim,' not recognised, must be cell array or char from 2d, 3d']);
    end
    
    if any(strcmpi(mode,fixed_dim))
        output='default';
    elseif strcmpi(dim,'default')
        if any(strcmpi(mode,default_2d))
            output='2d';
        elseif any(strcmpi(mode,default_3d))
            output='3d';
        end
    else
        output=dim;
    end
end
function output=validate_stations(mode)
station_modes={'beachball','faultplane'};
output=any(strcmpi(mode,station_modes));
end
function output=validate_pt(mode)
pt_modes={'beachball','radiation','faultplane'};
output=any(strcmpi(mode,pt_modes));
end
function [options]=Parser(MT,varargin)
    parser=inputParser();
    parser.KeepUnmatched=false;
    parser.FunctionName='MTplot';
    parser.addRequired('MT',@(x) assert(any([isnumeric(x),iscell(x),isstruct(x),ischar(x)&&exist(x,'file')==2]),'Value must be numeric or cell array or the filename and path'));
    parser.addOptional('Mode','beachball',@(x) validate_modes(x));
    parser.addOptional('Stations',{},@(x) assert(iscell(x),'Value must be cell array'));
    parser.addParamValue('Dimension','default',@(x) assert(any(validatestring(x,{'2d','3d','default'}))||iscell(x),'Value must be cell array or char from 2d,3d,default'));
    parser.addParamValue('StationMarkerSize',0,@(x) assert(isnumeric(x)||iscell(x),'Value must be cell array or numeric'));
    parser.addParamValue('Projection','EqualArea',@(x) assert(iscell(x)||any(validatestring(x,{'EqualAngle','EqualArea','u-v','tau-k'})),'Value must be cell array or from EqualAngle, EqualArea or u-v,tau-k depending on plot type'))
    parser.addParamValue('Colormap','Default',@(x) assert(any(validatestring(x,{'Parula','Default','Clear','BlueRed','BR','Jet','HSV','Hot','Cool','Spring','Summer','Autumn','Winter','Gray','Bone','Copper','Pink','Lines'})),'Value must be cell array or from Default,Clear,BlueRed,Jet,HSV,Hot,Cool,Spring,Summer,Autumn,Winter,Gray,Bone,Copper,Pink,Lines'))
    parser.addParamValue('WindowTitle','',@(x) assert(ischar(x),'Value must be char'));
    parser.addParamValue('Subtitle',false,@(x) assert(ischar(x)||iscell(x)||islogical(x),'Value must be cell array or char or boolean (for default alphabetical subtitles)'));
    parser.addParamValue('AxisTitle',false,@islogical);
    parser.addParamValue('Text',true,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('AxisLabel',true,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('TypeLabel',true,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('AxisLines',true,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('Contour',false,@(x) assert(isnumeric(x)||islogical(x)||iscell(x),'Value must be cell array, numeric value or boolean'));
    parser.addParamValue('StationProjection',true,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('PT',true,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('Lower',true,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('FullSphere',false,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('Phase','P', @(x) assert(iscell(x)||any(validatestring(x,{'P','S','SH','SV','P/SH','P/SV','SH/SV','P/S'})),'Value must be cell array or char from P, S, SH, SV, P/SH, P/SV, SH/SV or P/S'));
    parser.addParamValue('Abs',false, @(x) assert(iscell(x)||islogical(x),'Value must be cell array or logical'));
    parser.addParamValue('Presentation',false, @(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('PolarityErrorHighlight',false, @(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('Resolution',300, @(x) assert(isnumeric(x)||iscell(x),'Value must be cell array or numeric'));
    parser.addParamValue('FP',true, @(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('BA',false,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('C',[3,1,1,0,0,0,...
                                3,1,0,0,0,...
                                  3,0,0,0,...
                                    1,0,0,...
                                      1,0,...
                                        1],@(x) assert(isnumeric(x)||iscell(x),'Value must be cell array or numeric'));
    parser.addParamValue('Legend',false,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('Color','r',@(x) assert(ischar(x)||iscell(x)||(isnumeric(x)&&size(x,2)==3),'Value must be cell array or char'));
    parser.addParamValue('Names',{},@(x) assert(iscell(x),'Value must be cell array'));
    parser.addParamValue('StationDistribution',{},@(x) assert(iscell(x)||isstruct(x),'Value must be cell array or struct'));
    parser.addParamValue('Locations',[],@(x) assert(iscell(x)||(isnumeric(x) && size(x,2)==3),'Value must be cell array or numeric n by 3 array'));
    parser.addParamValue('R',6371,@isnumeric);
    parser.addParamValue('LocationUnits','latlon',@(x) assert(any(validatestring(x,{'latlon','km'}))||iscell(x),'Value must be cell array or char from latlon or km'));
    parser.addParamValue('Probability',[],@(x) assert(isnumeric(x)||iscell(x),'Value must be cell array or numeric'));
    parser.addParamValue('Panel',false,@(x) assert(islogical(x),'Value must be boolean'));
    parser.addParamValue('Options',false,@(x) isstruct(x)||islogical(x));
    parser.addParamValue('FigureHandle',0,@(x) assert(ishandle(x),'Value must correspond to valid figure handle'));
    parser.addParamValue('FontSize',12,@(x) assert(isnumeric(x),'Value must be numeric'));
    parser.addParamValue('LineWidth',1,@(x) assert(isnumeric(x),'Value must be numeric'));
    parser.addParamValue('Roman',false,@(x) assert(islogical(x),'Value must be boolean'));
    parser.addParamValue('Marker','o',@(x) assert(ischar(x)||iscell(x),'Value must be cell array or char'));
    parser.addParamValue('MarkerSize',6,@(x) assert(isnumeric(x)||iscell(x),'Value must be cell array or numeric'));
    parser.addParamValue('Radians',false,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('Marginalised',true,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('Superposition',false,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('Chain',[],@(x) assert(isnumeric(x)||iscell(x),'Value must be cell array or numeric'));
    parser.addParamValue('Movie',false,@(x) assert(islogical(x),'Value must be boolean'))
    parser.addParamValue('Logarithm',false,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'))
    parser.addParamValue('ProjectionAxis',[],@(x) assert(isnumeric(x)||iscell(x),'Value must be cell array or numeric'));
    parser.addParamValue('MaxSource',false,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('Interp',false,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('InteriorLines',true,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('Samples',0,@(x) assert(isnumeric(x)||iscell(x),'Value must be cell array or numeric'));
    parser.addParamValue('SNR',0,@(x) assert(isnumeric(x)||iscell(x),'Value must be cell array or numeric'));
    parser.addParamValue('Coordinate','u',@(x) assert(ischar(x)||iscell(x),'Value must be cell array or char'));
    parser.addParamValue('Normalise',false,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('Scale',true,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    parser.addParamValue('Only_Picked',false,@(x) assert(islogical(x)||iscell(x),'Value must be cell array or boolean'));
    % HIDDEN FOR PANEL INTERFACING
    parser.addParamValue('PanelIndex',false,@(x) assert(islogical(x)||isnumeric(x),'Value must be numeric array or boolean'))
        function s=getString(z)
            if strcmpi(char(class(z)),'char')
                s={z};
            else
                s={''};
            end
        end
    stringargs=cellfun(@getString,varargin);
    if ismember('help',stringargs)
        help MTplot;
        error('MTplot:helpError','No Input Arguments Specified')
    end
    parser.parse(MT,varargin{:});
    options=parser.Results;
    unmatched=parser.Unmatched;
    
    options.PanelIndex=false;
    options.PanelMode=false;
    
end
function options=parse_options(options)
    %MTcheck
    options.MT=MTcheck(options.MT,false);
    if (islogical(options.Probability)&&options.Probability)&&isstruct(options.MT)
        options.Probability=options.MT.Probability;
        if max(options.Probability)==0
            options.Probability=exp(options.MT.ln_pdf-max(options.MT.ln_pdf));
        end
    elseif ~numel(options.Probability)
        try
            if islogical(options.Options.Probability)&&options.Options.Probability&&isstruct(options.MT)
                options.Options.Probability=options.MT.Probability;
                if max(options.Options.Probability)==0
                    options.Options.Probability=exp(options.MT.ln_pdf-max(options.MT.ln_pdf));
                end
            end
        catch
        end
    end
        
    %superposition_modes={'radiation','amplitude','amplituderatio'};
    multiple_modes={'faultplane',...
           'hudson',...
           'lune',...
           'tape',...
           'orientation',...
           'tnp',...
           'component',...
           'eigenvalues',...
           'sdr','sdrsilhouette'...
           '3dlocation',...
           'coordinate',...
           'hx'};
    prob_multiple_modes={};
    %Options struct passed - other arguments ignored
    
    if isstruct(options.Options)
        %Handle different MT inputs
        options.Options.MT=options.MT;
        options=options.Options;
    else
        %What does PanelMode do?
        options.PanelMode=false;
        if options.Panel
            options.PanelMode=true;
        end
    end
    %Handle mode check
    options.Mode=validate_modes(options.Mode,true);    
    if isstruct(options.MT)
        if ~any(strcmpi(options.Mode,multiple_modes))&&(~(isnumeric(options.Probability)&&numel(options.Probability)&&any(strcmpi(options.Mode,prob_multiple_modes))))&&size(options.MT.MTSpace,2)>1
            error(['Cannot use Events structure for ',options.Mode,' plots with MTSpace dimension > 1'])
        elseif ~any(strcmpi(options.Mode,multiple_modes))
            options.MT=MTcheck(options.MT.MTSpace);
        end
    end
    %Check panel and return
    if iscell(options.Mode)||iscell(options.Dimension)||iscell(options.Projection)||(iscell(options.MT)&&~any(strcmpi(options.Mode,multiple_modes)))||options.Panel||(iscell(options.MT)&&iscell(options.Probability)&&~options.MaxSource&&any(strcmpi(options.Mode,multiple_modes)))&&~sum(options.PanelIndex)
        options.Panel=true;
        options.PanelMode=true;
        %No validation with panel plot - just set plot fns etc

        %Check geometry
        if iscell(options.MT)
            options.Geometry=size(options.MT);
        elseif iscell(options.Mode)
            options.Geometry=size(options.Mode);
        elseif iscell(options.Dimension)
            options.Geometry=size(options.Dimension);
        end
        [options.TitleFn,options.PlotFn,options.BackgroundFn]=getFunctionHandles(options);
        if ~iscell(options.Scale)&&options.Scale&&(numel(options.Probability)>0&&any(cellfun(@isnumeric,reshape(options.Probability,1,numel(options.Probability)))))
            mP=0;
            for i=1:size(options.Probability,1)
                for j=1:size(options.Probability,2)
                    if isnumeric(options.Probability{i,j})
                        mP=max([mP,max(options.Probability{i,j})]);
                    end
                end
            end
            for i=1:size(options.Probability,1)
                for j=1:size(options.Probability,2)
                    if isnumeric(options.Probability{i,j})
                        options.Probability{i,j}=options.Probability{i,j}/mP;
                    end
                end
            end
        end
            
        return
    end
    if iscell(options.Probability)&&numel(options.Probability)==1
        if isstruct(options.MT)
        options.Probability=ones(1,size(options.MT.MTSpace,2));
        else
        options.Probability=ones(1,size(options.MT,2));
        end
    end
    if options.Scale&&numel(options.Probability)
        options.Probability=options.Probability/max(options.Probability);
    end
    %Check stations
    options.StationPlot=validate_stations(options.Mode);
    %Check PT
    options.PT=options.PT&&validate_pt(options.Mode);
    %Not panel plot - plotting
    
    %Handle dimension checks - no fails, dimension is forced in cases with
    %   fixed dimension (not checked in plot fns)
    options.Dimension=validate_dimensions(options.Dimension,options.Mode,options.Panel);
    if (iscell(options.MT)||isstruct(options.MT))&&(~any(strcmpi(options.Mode,multiple_modes))&&(isnumeric(options.Probability)&&numel(options.Probability)&&~any(strcmpi(options.Mode,prob_multiple_modes))))
        error(['Cannot plot multiple events for ',options.Mode,'\nPanel option not set.'])
    end
    %Default Settings
    %Station Marker Size
    if ~iscell(options.StationMarkerSize)&&options.StationMarkerSize==0
        options.StationMarkerSize=8;
        if options.Presentation
            options.StationMarkerSize=15;
        end
    end
    %Text
    if iscell(options.Text)&&numel(options.Text)
        options.Text=true;
        if options.Presentation
            options.Text=false;
        end
    end
    %Legend set up
    if iscell(options.MT)
        if ~iscell(options.Color)
            options.Color={options.Color};
        end
        if any(strcmpi(options.Mode,{'hudson','lune'}))
            if length(options.Color)~=length(options.MT)
                DefaultColor=[1,0,0];
                for i=length(options.Color)+1:length(options.MT)
                    options.Color{i}=DefaultColor;
                end
            end
            if options.Legend
                if length(options.Names)~=length(options.MT)
                    DefaultName='Solution ';
                    for i=length(options.Color)+1:length(options.MT)
                        options.Name{i}=[DefaultName,mat2str(i)];
                    end
                end
                options.LegendColors=mat2cell(ones(1,3*length(options.MT)),1,3*ones(1,length(options.MT)));
                for i=1:size(options.MT,2)
                   rgbcolor=options.Color{i};
                   options.LegendColors{i}=sprintf('[rgb]{%4.2f %4.2f %4.2f}',rgbcolor);
                end
                options.LegendColors=options.LegendColors';
            end
        end
    end
    %Projection Function Set-up
    if strcmpi(options.Mode,'hudson') && ~any(strcmpi(options.Projection,{'u-v','tau-k'}))
        options.Projection='u-v';
    elseif strcmpi(options.Dimension,'2d')&&~any(strcmpi(options.Projection,{'EqualAngle','EqualArea'}))
        options.Projection='EqualArea';        
    elseif ~strcmpi(options.Dimension,'2d') && ~(strcmpi(options.Mode,'hudson') && any(strcmpi(options.Projection,{'u-v','tau-k'})))
        options.Projection='PassThrough';
    end    
    if strcmpi(options.Projection,'EqualAngle')
        options.ProjFn=@EqualAngleProj;
    elseif strcmpi(options.Projection,'EqualArea')
        options.ProjFn=@EqualAreaProj;
    elseif strcmpi(options.Projection,'tau-k')
        options.ProjFn=@taukProj;
    elseif strcmpi(options.Projection,'u-v')
        options.ProjFn=@uvProj;
    else
        options.ProjFn=@passthrough;
        options.StationProjection=false;
    end
    %Convert Locations to km
    if strcmpi(options.Mode,'3dLocations')
        if size(options.Locations,1)~=max(size(MT))
            error('Error Using 3D Location Plot, number of locations do not match number of events. Please provide locations as an array of either [Lat,Lon,Depth] or [N,E,Depth]')
        end
        if strcmpi(options.LocationUnits,'latlon')
            R=options.R;
            convertLatToKm=@(x) pi*R*x/180;
            convertLonToKm=@(x,y) R*x.*cosd(y)*pi/180;
            options.Locations(:,1)=convertLatToKm(options.Locations(:,1));
            options.Locations(:,2)=convertLonToKm(options.Locations(:,2),options.Locations(:,1));
        end
    end
    options.Colormap=getColormap(options);
    [options.TitleFn,options.PlotFn,options.BackgroundFn]=getFunctionHandles(options);
    %Probability normalisation
    if ~options.Scale&&numel(options.Probability)&&isnumeric(options.Probability)&&max(options.Probability)>1
            options.Probability=options.Probability/max(options.Probability);
    end
end
function [MT,options]=sample_check(MT,options)
sample_plot_types={'FaultPlanePlot'};
if options.Samples>0 && ~strcmpi(char(options.PlotFn),'PanelPlot') &&any(strcmpi(char(options.PlotFn),sample_plot_types))
    indices=[];
    if isstruct(MT)
        if options.Samples<size(MT.MTSpace,2)    
            if strcmpi(char(options.PlotFn),'FaultPlanePlot')
                [~,indices]=sort(MT.Probability,'descend');
                indices=indices(1:options.Samples);
            else
                indices=randsample(size(MT.MTSpace,2),options.Samples);
            end
            fn = fieldnames(MT);
            event=MT;
            for str = fn'
                if size(MT.(char(str)),2)==size(MT.MTSpace,2)
                event.(char(str)) = MT.(char(str))(:,indices);
                end
            end
            MT=event;
        end
    elseif options.Samples<size(MT,2) 
        indices=randsample(size(MT,2),options.Samples);
        MT=MT(indices);
    end
    if numel(options.Probability)&&numel(indices) 
        options.Probability=options.Probability(indices);
        if ~options.Scale
        options.Probability=options.Probability/max(options.Probability);
        end
    end
end
end
%
% Helper Functions
%
function [titleHandle,plotHandle,backgroundHandle]=getFunctionHandles(options)
if options.Panel
    titleHandle=@PanelTitle;
    plotHandle=@PanelPlot;
    backgroundHandle=@PanelBackground;
elseif strcmpi(options.Mode,'radiation')
    titleHandle=@RadiationTitle;
    plotHandle=@AmplitudePlot;
    backgroundHandle=@GenericBackground;
elseif strcmpi(options.Mode,'beachball')
    titleHandle=@BeachBallTitle;
    plotHandle=@AmplitudePlot;
    backgroundHandle=@GenericBackground;
elseif strcmpi(options.Mode,'hudson')
    titleHandle=@HudsonTitle;
    plotHandle=@HudsonPlot;
    backgroundHandle=@HudsonBackground;
elseif strcmpi(options.Mode,'lune')
    titleHandle=@LuneTitle;
    plotHandle=@LunePlot;
    backgroundHandle=@LuneBackground;
elseif strcmpi(options.Mode,'hx')
    titleHandle=@HXTitle;
    plotHandle=@HXPlot;
    backgroundHandle=@HXBackground;
elseif strcmpi(options.Mode,'coordinate')
    titleHandle=@CoordinateTitle;
    plotHandle=@CoordinatePlot;
    backgroundHandle=@CoordinateBackground;
elseif strcmpi(options.Mode,'tape')
    titleHandle=@TapeTitle;
    plotHandle=@TapePlot;
    backgroundHandle=@OrientationBackground;
elseif strcmpi(options.Mode,'orientation')
    titleHandle=@OrientationTitle;
    plotHandle=@OrientationDistPlot;
    backgroundHandle=@OrientationBackground;
elseif strcmpi(options.Mode,'riedeseljordan')
    titleHandle=@RiedeselJordanTitle;
    plotHandle=@RiedeselJordanPlot;
    backgroundHandle=@GenericBackground;
elseif strcmpi(options.Mode,'faultplane')
    titleHandle=@FaultPlaneTitle;
    plotHandle=@FaultPlanePlot;
    backgroundHandle=@FaultPlaneBackground;
elseif strcmpi(options.Mode,'tnp')
    titleHandle=@TNPPDFTitle;
    plotHandle=@TNPPDFPlot;
    backgroundHandle=@TNPPDFBackground;
elseif any(strcmpi(options.Mode,{'sdr','sdrsilhouette'}))
    titleHandle=@SDRPDFTitle;
    plotHandle=@SDRPDFPlot;
    backgroundHandle=@SDRPDFBackground;
elseif strcmpi(options.Mode,'3dlocation')
    titleHandle=@LocationTitle;
    plotHandle=@LocationBeachBalls;
    backgroundHandle=@LocationBackground;
elseif strcmpi(options.Mode,'component')
    titleHandle=@ComponentTitle;
    plotHandle=@ComponentPlot;
    backgroundHandle=@ComponentBackground;
elseif strcmpi(options.Mode,'eigenvalues')
    titleHandle=@EigDistTitle;
    plotHandle=@EigDistPlot;
    backgroundHandle=@ComponentBackground;
    
end
end
%
% Projection Passthrough Function
%
function [x,y,z]=passthrough(x,y,z,~)
end
%
% Additional Information Plotting Functions
%
function PT(MT,h,options)
set(0, 'currentfigure', h);
hold on;
[T,N,P]=MT2TNPE(MT);
[N1,N2]=TP2FP(T,P);
Normals=[N1,N2,-N1,-N2];
[~,I]=sort(Normals(1,:));
Normals=Normals(:,I);
[Tx,Ty,Tz]=options.ProjFn([T(1,:),-T(1,:)],[T(2,:),-T(2,:)],[T(3,:),-T(3,:)],options);
[Nx,Ny,Nz]=options.ProjFn([N(1,:),-N(1,:)],[N(2,:),-N(2,:)],[N(3,:),-N(3,:)],options);
[Px,Py,Pz]=options.ProjFn([P(1,:),-P(1,:)],[P(2,:),-P(2,:)],[P(3,:),-P(3,:)],options);
[N1x,N1y,N1z]=options.ProjFn([Normals(1,1:size(Normals,2)/4),Normals(1,3*size(Normals,2)/4+1:end)],[Normals(2,1:size(Normals,2)/4),Normals(2,3*size(Normals,2)/4+1:end)],[Normals(3,1:size(Normals,2)/4),Normals(3,3*size(Normals,2)/4+1:end)],options);
[N2x,N2y,N2z]=options.ProjFn(Normals(1,size(Normals,2)/4+1:3*size(Normals,2)/4),Normals(2,size(Normals,2)/4+1:3*size(Normals,2)/4),Normals(3,size(Normals,2)/4+1:3*size(Normals,2)/4),options);
Tx=sort(Tx);
Ty=sort(Ty);
Tz=sort(Tz);
Nx=sort(Nx);
Ny=sort(Ny);
Nz=sort(Nz);
Px=sort(Px);
Py=sort(Py);
Pz=sort(Pz);
N1x=sort(N1x);
N1y=sort(N1y);
N1z=sort(N1z);
N2x=sort(N2x);
N2y=sort(N2y);
N2z=sort(N2z);
if any(strcmpi(options.Mode, {'Lune3d','Lune3dPDF'}))
    for i=1:size(Tx,2)
        line([-Tx(i)',Tx(i)'],[-Ty(i)',Ty(i)'],[-Tz(i)',Tz(i)'],'Color','red','LineWidth',options.LineWidth);
        line([-Px(i)',Px(i)'],[-Py(i)',Py(i)'],[-Pz(i)',Pz(i)'],'Color','blue','LineWidth',options.LineWidth);
    end
% elseif iscell(MT)%||isstruct(MT)
%     if ~isempty(options.Probability)
%         scatter3(Tx,Ty,Tz,'.','CData',[ones(size(Tx));0.8-0.8*[options.Probability,options.Probability];0.8-0.8*[options.Probability,options.Probability]]');
%         scatter3(Px,Py,Pz,'.','CData',[0.8-0.8*[options.Probability,options.Probability];0.8-0.8*[options.Probability,options.Probability];ones(size(Px))]');
%         scatter3(Nx,Ny,Nz,'.','CData',[0.8-0.8*[options.Probability,options.Probability];ones(size(Nx));0.8-0.8*[options.Probability,options.Probability]]');
%         scatter3(N1x,N1y,N1z,'.','CData',0.5*[1-[options.Probability,options.Probability];1-[options.Probability,options.Probability];1-[options.Probability,options.Probability]]');
%         scatter3(N2x,N2y,N2z,'.','CData',0.5*[1-[options.Probability,options.Probability];1-[options.Probability,options.Probability];1-[options.Probability,options.Probability]]');
%     else
%         scatter3(Tx,Ty,Tz,'.r');
%         scatter3(Px,Py,Pz,'.b');
%         scatter3(Nx,Ny,Nz,'.g');
%         scatter3(N1x,N1y,N1z,'.k');
%         scatter3(N2x,N2y,N2z,'.k');
%     end
elseif strcmpi(options.Dimension,'2d')
    grey=[0.5 0.5 0.5];
     if ~isempty(options.Probability)
        scatter3(Tx,Ty,Tz,'.','CData',[ones(size(Tx));0.8-0.8*[options.Probability,options.Probability];0.8-0.8*[options.Probability,options.Probability]]');
        scatter3(Px,Py,Pz,'.','CData',[0.8-0.8*[options.Probability,options.Probability];0.8-0.8*[options.Probability,options.Probability];ones(size(Px))]');
        scatter3(Nx,Ny,Nz,'.','CData',[0.8-0.8*[options.Probability,options.Probability];ones(size(Nx));0.8-0.8*[options.Probability,options.Probability]]');
        scatter3(N1x,N1y,N1z,'.','CData',0.5*[1-[options.Probability,options.Probability];1-[options.Probability,options.Probability];1-[options.Probability,options.Probability]]');
        scatter3(N2x,N2y,N2z,'.','CData',0.5*[1-[options.Probability,options.Probability];1-[options.Probability,options.Probability];1-[options.Probability,options.Probability]]');
     else
        plot3(Tx,Ty,Tz,'h','MarkerEdgeColor','w','MarkerFaceColor','w','MarkerSize',8);
        plot3(Px,Py,Pz,'h','MarkerEdgeColor','w','MarkerFaceColor','w','MarkerSize',8);
        plot3(Nx,Ny,Nz,'h','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8);
        plot3(N1x,N1y,N1z,'h','MarkerEdgeColor',grey,'MarkerFaceColor',grey,'MarkerSize',8);
        plot3(N2x,N2y,N2z,'h','MarkerEdgeColor',grey,'MarkerFaceColor',grey,'MarkerSize',8);
     end

        
elseif strcmpi(options.Dimension,'3d')
    line([-Tx,Tx],[-Ty,Ty],[-Tz,Tz],'Color','red','LineWidth',options.LineWidth);
    line([-Nx,Nx],[-Ny,Ny],[-Nz,Nz],'LineWidth',options.LineWidth);
    line([-Px,Px],[-Py,Py],[-Pz,Pz],'Color','blue','LineWidth',options.LineWidth);
    line([-N1x,N1x],[-N1y,N1y],[-N1z,N1z],'Color','black','LineWidth',options.LineWidth);
    line([-N2x,N2x],[-N2y,N2y],[-N2z,N2z],'LineWidth',options.LineWidth);
    if options.Text
        text(Tx,Ty,Tz-2,'T-axis','FontSize',options.FontSize);
        text(Nx,Ny,Nz-2,'N-axis','FontSize',options.FontSize);
        text(Px,Py,Pz-2,'P-axis','FontSize',options.FontSize);
        text(N1x,N1y,N1z-2,'Normal1','FontSize',options.FontSize);
        text(N2x,N2y,N2z-2,'Normal2','FontSize',options.FontSize);
    end
        
end
if ~strcmpi(options.Dimension,'3d') && options.Text
    text(mean(Tx(1:size(T,2))),mean(Ty(1:size(T,2))),mean(Tz(1:size(T,2))),'T-axis','HorizontalAlignment','Left','VerticalAlignment','bottom','FontSize',options.FontSize);
    text(mean(Tx(size(T,2)+1:end)),mean(Ty(size(T,2)+1:end)),mean(Tz(size(T,2)+1:end)),'T-axis','HorizontalAlignment','Left','VerticalAlignment','bottom','FontSize',options.FontSize);
    text(mean(Px(1:size(P,2))),mean(Py(1:size(P,2))),mean(Pz(1:size(P,2))),'P-axis','HorizontalAlignment','Left','VerticalAlignment','bottom','Color',grey,'FontSize',options.FontSize);
    text(mean(Px(size(P,2)+1:end)),mean(Py(size(P,2)+1:end)),mean(Pz(size(P,2)+1:end)),'P-axis','HorizontalAlignment','Left','VerticalAlignment','bottom','Color',grey,'FontSize',options.FontSize);
    text(mean(Nx(1:size(N,2))),mean(Ny(1:size(N,2))),mean(Nz(1:size(N,2))),'N-axis','HorizontalAlignment','Left','VerticalAlignment','bottom','Color','white','FontSize',options.FontSize);
    text(mean(Nx(size(N,2)+1:end)),mean(Ny(size(N,2)+1:end)),mean(Nz(size(N,2)+1:end)),'N-axis','HorizontalAlignment','Left','VerticalAlignment','bottom','Color','white','FontSize',options.FontSize);
    text(mean(N1x(1:size(N1,2))),mean(N1y(1:size(N1,2))),mean(N1z(1:size(N1,2))),'Normal 1','HorizontalAlignment','Left','VerticalAlignment','bottom','FontSize',options.FontSize);
    text(mean(N1x(size(N1,2)+1:end)),mean(N1y(size(N1,2)+1:end)),mean(N1z(size(N1,2)+1:end)),'Normal 1','HorizontalAlignment','Left','VerticalAlignment','bottom','FontSize',options.FontSize);
    text(mean(N2x(1:size(N2,2))),mean(N2y(1:size(N2,2))),mean(N2z(1:size(N2,2))),'Normal 2','HorizontalAlignment','Left','VerticalAlignment','bottom','FontSize',options.FontSize);
    text(mean(N2x(size(N2,2)+1:end)),mean(N2y(size(N2,2)+1:end)),mean(N2z(size(N2,2)+1:end)),'Normal 2','HorizontalAlignment','Left','VerticalAlignment','bottom','FontSize',options.FontSize);
end
hold off;
end
function Axis(h,options)
set(0, 'currentfigure', h);
maxValues=(options.ProjFn([1;0;0;0],[0;1;0;0],[0;0;1;-1]));
maxValues(maxValues==Inf)=0;
maxValue=max(maxValues);
if options.AxisLines
    
    line(1.2*[-maxValue,maxValue],[0,0],'Color','black','LineWidth',0.5*options.LineWidth);
    line([0,0],1.2*[-maxValue,maxValue],'Color','black','LineWidth',0.5*options.LineWidth);
    if options.AxisLabel
        text(1.3*maxValue,0,0,'North','Color','black','HorizontalAlignment','Center','VerticalAlignment','Bottom','FontSize',options.FontSize);
        text(0,1.3*maxValue,0,'East','Color','black','FontSize',options.FontSize);
    end
end
if strcmpi(options.Dimension,'3d') && options.AxisLines
    line([0,0],[0,0],1.2*[-maxValue,maxValue],'Color','black','LineWidth',options.LineWidth);
    if options.AxisLabel
    text(0,0,1.3*maxValue,'Down','Color','black','FontSize',options.FontSize)
    end
    set(gca,'Zdir','rev')
end
end
function Stations(h,options)
if isstruct(options.StationDistribution)&&~isempty(options.StationDistribution.Distribution)
    set(0, 'currentfigure', h);
    hold on
    if ~iscell(options.StationDistribution.Distribution)
        [nSamples,nStations,~]=size(options.StationDistribution.Distribution);
        newflag=false;
    else
        nSamples=numel(options.StationDistribution.Distribution);
        nStations=size(options.StationDistribution.Distribution{1}.Azimuth,1);
        newflag=true;
    end
    xsta=zeros(nSamples,nStations)';
    ysta=zeros(nSamples,nStations)';
    zsta=zeros(nSamples,nStations)';
    if newflag
        for i=1:nSamples
            [xsta(:,i),ysta(:,i),zsta(:,i)]=toa2xyz(options.StationDistribution.Distribution{i}.Azimuth,options.StationDistribution.Distribution{i}.TakeOffAngle,options);
        end
        sampleName=mat2cell(options.StationDistribution.Distribution{1}.Name,ones(size(options.StationDistribution.Distribution{1}.Name,1),1));
    else
        for i=1:nStations
            [xsta(i,:),ysta(i,:),zsta(i,:)]=toa2xyz(cell2mat(options.StationDistribution.Distribution(:,i,2))',cell2mat(options.StationDistribution.Distribution(:,i,3))',options);
        end 
        sampleName=options.StationDistribution.Distribution(1,:,1);
    end
    [Xsta,Ysta,Zsta]=options.ProjFn(xsta,ysta,zsta,options);
    Polarity=zeros(nStations,1);
    if ~isempty(options.Stations)
        [xtext,ytext,ztext,name,pol,Pol]=ExtractStations(options);
        xt=0*xtext;
        yt=0*ytext;
        zt=0*ztext;
        for n=1:nStations
            flag=true;
            for m=1:numel(name)
                if strcmp(strtrim(sampleName{n}),strtrim(name(m)))
                    %Match sample name to station name
                    Polarity(n)=Pol(m);
                    Ptext(n,:)=pol(m,:);
                    xt(n)=xtext(m);
                    yt(n)=ytext(m);
                    zt(n)=ztext(m);
                    flag=false;
                end
            end
            if flag
                xt(n)=mean(xsta(n,:));
                yt(n)=mean(ysta(n,:));
                zt(n)=mean(zsta(n,:));
                if Polarity(n)>0
                    Ptext(n,:)=['^','r'];
                elseif Polarity(n)<0
                    Ptext(n,:)=['v','b'];
                else
                    Ptext(n,:)=['o','w'];
                end
            end
        end
        [Xtext,Ytext,Ztext]=options.ProjFn(xt,yt,zt,options);
    end
    P=options.StationDistribution.Probability/max(options.StationDistribution.Probability);
    if size(P,2)==1
        P=P';
    end
    if ~isempty(options.Stations)
        if options.Only_Picked
            Polarity(Polarity==0)=nan;
        end
    C=kron(Polarity,ones(1,nSamples)).*kron((P/(max(P)*2)+0.5),ones(nStations,1));
    else
    C=kron((P/(max(P)*2)+0.5),ones(nStations,1));
    end
        
    scatter3(reshape(Xsta,1,nSamples*nStations),reshape(Ysta,1,nSamples*nStations),reshape(Zsta,1,nSamples*nStations)+0.5,options.MarkerSize,reshape(C,1,nSamples*nStations),'.')
    set(gca,'CLim',[-1,1])
    if ~options.Presentation && options.Text && ~isempty(options.Stations)
        text(Xtext,Ytext,Ztext,sampleName,'HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',options.FontSize)
    end
    hold off
    if ~isempty(options.Stations)&&options.StationMarkerSize>1
        hold on
        
        [xtext,ytext,ztext,name,pol,Pol]=ExtractStations(options);
        [Xtext,Ytext,Ztext]=options.ProjFn(xtext,ytext,ztext,options);
        Ztext=Ztext+1;        
        for i=1:length(Xtext)
            for m=1:length(sampleName)
                if strcmp(strtrim(sampleName{m}),strtrim(name(i)))
                    if pol(i,2)=='b'||pol(i,2)=='r'
                        markerEdge='w';
                    else
                        markerEdge=[0.3,0.3,0.3];
                    end
                        plot3(Xtext(i),Ytext(i),Ztext(i),'Marker',pol(i,1),'MarkerFaceColor',pol(i,2),'MarkerEdgeColor',markerEdge,'LineWidth',2,'MarkerSize',options.StationMarkerSize)
                end
            end
        end
        hold off
    end
elseif ~isempty(options.Stations)
    set(0, 'currentfigure', h);
    hold on
    [xsta,ysta,zsta,name,pol,polVals]=ExtractStations(options);
    [Xsta,Ysta,Zsta]=options.ProjFn(xsta,ysta,zsta,options);
    Zsta=Zsta+1;
    errors=ones(1,length(Xsta));
    if options.PolarityErrorHighlight
        errors=checkStationPol(xsta,ysta,zsta,polVals,options.MT);
    end
    for i=1:length(Xsta)
            if options.PolarityErrorHighlight && errors(i)>0
                plot3(Xsta(i),Ysta(i),Zsta(i),'Marker',pol(i,1),'MarkerFaceColor',pol(i,2),'MarkerEdgeColor','white','LineWidth',2,'MarkerSize',options.StationMarkerSize)
            else
                plot3(Xsta(i),Ysta(i),Zsta(i),'Marker',pol(i,1),'MarkerFaceColor',pol(i,2),'MarkerEdgeColor','black','MarkerSize',options.StationMarkerSize)
            end
            if ~options.Presentation && options.Text
                text(Xsta(i),Ysta(i),Zsta(i),name(i),'HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',options.FontSize)
            end
    end
    hold off
end
end
function errors=checkStationPol(xsta,ysta,zsta,pol,MT)
mt=MTcheck(MT);
MT=[mt(1,1);mt(2,2);mt(3,3);sqrt(2)*mt(1,2);sqrt(2)*mt(1,3);sqrt(2)*mt(2,3)];
theta=acos(zsta)';
phi=atan2(ysta,xsta)';
staCoeffs=[cos(phi).*cos(phi).*sin(theta).*sin(theta),...
        sin(phi).*sin(phi).*sin(theta).*sin(theta),...
        cos(theta).*cos(theta),...
        sqrt(2)*sin(phi).*cos(phi).*sin(theta).*sin(theta),...
        sqrt(2)*cos(phi).*cos(theta).*sin(theta),...
        sqrt(2)*sin(phi).*cos(theta).*sin(theta)];
errors=(sign(staCoeffs*MT).*double(pol));
errors=errors==-1;
end
function [x,y,z,name,pol,polVals]=ExtractStations(options)
%sta is a cell array of station information - name,azimuth and take off
%angle and polarity
    n=size(options.Stations);
    for i=1:n(1)
        [x(i),y(i),z(i)]=toa2xyz(cell2mat(options.Stations(i,2)),cell2mat(options.Stations(i,3)),options);
        name(i)=options.Stations(i,1);
        p=cell2mat(options.Stations(i,4));
        if p>0
            pol(i,:)=['^','r'];
        elseif p<0
            pol(i,:)=['v','b'];
        else
            pol(i,:)=['o','w'];
        end
        polVals(1,i)=p;
    end 
    polVals=polVals';
end

%
% Title Functions
%
function title=PanelTitle(~,~)
    title='Multiplot';
end
function title=BeachBallTitle(options,~)
if strcmpi(options.Dimension,'2d')&&strcmpi(options.Projection,'EqualAngle')
    title=[options.Phase,'-wave Equal Angle '];
elseif strcmpi(options.Dimension,'2d')
    title=[options.Phase,'-wave Equal Area '];
else
    title=[options.Phase,'-wave '];
end

if strcmpi(options.Dimension,'2d')&&options.Lower
    title=[title,'Lower Hemisphere '];
elseif strcmpi(options.Dimension,'2d')
    title=[title,'Upper Hemisphere '];
end
if strcmpi(options.Dimension,'2d')&&options.FullSphere
    title=[title,'Full Sphere '];
elseif strcmpi(options.Dimension,'2d')
    title=[title,'Half Sphere '];
end    
if options.Logarithm
    title=[title,'Logarithm '];
end
title=[title,'BeachBall Plot'];
end
function title=TapeTitle(options,~)
title='Tape Distribution';
if options.Marginalised
    title=['Marginalised ',title];
else
    title=['Silhouette ',title];
end
end
function title=EigDistTitle(options,~)
title='Eigenvalue Distribution';
if options.Marginalised
    title=['Marginalised ',title];
else
    title=['Silhouette ',title];
end
end
function title=LuneTitle(~)
title=['Lune plot of moment tensors'];
end
function title=HXTitle(~)
title=['HX equal area plot of moment tensor source type'];
end
function title=CoordinateTitle(options,~)
title=['Coordinate histogram ',options.Coordinate];
end
function title=FaultPlaneTitle(~)
title='Fault plane plot';
end
function title=RadiationTitle(options,~)
title=[options.Phase,'-wave Radiation Pattern'];
end
function title=RiedeselJordanTitle(options,~)
if strcmpi(options.Projection,'EqualAngle')
    title='Riedesel-Jordan Source Plot - Equal Angle Projection';
else
    title='Riedesel-Jordan Source Plot - Equal Area Projection';
end

end
function title=HudsonTitle(options,~)
if strcmpi(options.Projection,'tau-k')
    title='Hudson Plot - tau,k';
else
    title='Hudson Plot - u,v';
end
end
function title=OrientationTitle(~,~)
    title='Strike, Dip and Rake PDFs';
end
function title=TNPPDFTitle(~,~)
    title='T, N, P PDFs';
end
function title=SDRPDFTitle(~,~)
    title='SDR PDFs';
end
function title=ComponentTitle(~,~)
title='Component Probability histogram';
end
function title=LocationTitle(~,~)
title='Location Beachball distribution';
end
%
% Background Functions
%
function GenericBackground(MT,h,options)
set(0, 'currentfigure', h);
if options.PanelMode
    freezeColors
end
if options.PT
    PT(MT,h,options)
end
if options.StationPlot
    Stations(h,options)
end
if options.AxisLines
    Axis(h,options)
end
axis normal;
axis square;
axis off;
grid off;
if strcmpi(options.Dimension,'2d')
    set(gca,'view',[-90 90])
    set(gca,'Ydir','rev');
    if any(strcmpi(options.Mode,{'beachball','faultplane'}))
        [x,y,z]=GetGreatCircle([1,0,0],[0,1,0]);
        [x,y,z]=options.ProjFn(x,y,z,options);
        hold on;
        plot3(x,y,z,'k');
        hold off;
        if ~options.FullSphere
        lim=[-1.5,1.5];
        else
        lim=[-3,3];
        end
        if options.AxisLabel
            lim=1.4*lim;
        end
        xlim(lim);
        ylim(lim);
            
        
    end

end
if strcmpi(options.Dimension,'3d')
    set(gca,'ZDir','nor')
end
% set(h,'Color','w');
end
function PanelBackground(~,h,~,~,~,~)
set(0, 'currentfigure', h);

end
function OrientationBackground(MT,h,options)
set(0, 'currentfigure', h);
set(h,'Color','w');
end
function CoordinateBackground(~,h,~)
set(0, 'currentfigure', h);
set(h,'Color','w');
set(gca,'YTick',[0]);
set(gca,'YTickLabel',{'0'});
box off;
end
function TNPPDFBackground(MT,h,options)
set(0, 'currentfigure', h);
if options.PanelMode
    freezeColors
end
if options.AxisLines
    Axis(h,options)
end
axis normal;
axis square;
axis off;
grid off;
if strcmpi(options.Dimension,'2d')
    set(gca,'view',[90,-90]);
    [x,y,z]=GetGreatCircle([1,0,0],[0,1,0]);
    [x,y,z]=options.ProjFn(x,y,z,options);
    hold on;
    plot3(x,y,z,'k');
    hold off;
end
set(gca,'Ydir','normal');
set(h,'Color','w');
end
function SDRPDFBackground(MT,h,options)
set(0, 'currentfigure', h);
if options.PanelMode
    freezeColors
end
set(h,'Color','w');
end
function ComponentBackground(MT,h,options)
set(0, 'currentfigure', h)
set(h,'Color','w');
end
function LocationBackground(~,h,options)
set(0, 'currentfigure', h);
% axis([Xmax(1)-5,Xmax(2)+5,Ymax(1)-5,Ymax(2)+5,0,Zmax(2)+5]);
axis normal;
axis square;
grid off;
set(gca,'view',[-90 90])
% XTicks=linspace(Xmax(1)-5,Xmax(2)+5,5);
% YTicks=linspace(Ymax(1)-5,Ymax(2)+5,5);
% ZTicks=linspace(0,Zmax(2)+5,5);
if strcmpi(options.LocationUnits,'latlon')
    R=options.R;
    convertKmToLat=@(x) 180*x/(pi*R);
    convertKmToLon=@(x,y) x*180./(R*cosd(convertKmToLat(y))*pi);
%     XTickLabels=convertKmToLat(XTicks);
%     YTickLabels=convertKmToLon(YTicks,kron(XTicks(1,3),ones(1,5)));
    xlabel 'Latitude (degrees)'
    ylabel 'Longitude (degrees)'
else
%     XTickLabels=XTicks;
%     YTickLabels=YTicks;
    xlabel 'North (km)'
    ylabel 'East (km)'
end
% ZTickLabels=ZTicks;
zlabel 'Depth (km)'
% set(gca,'XTick',XTicks)
% set(gca,'XTickLabel',XTickLabels)
% set(gca,'YTick',YTicks)
% set(gca,'YTickLabel',YTickLabels)
% set(gca,'ZTick',ZTicks)
% set(gca,'ZTickLabel',ZTickLabels)
set(gca,'DataAspectRatio',[1,1,1]);
set(gca,'ZDir','Reverse');
set (gca,'Xdir','Reverse');
box on;
set(h,'Color','w');
end
function HudsonBackground(~,h,options)
if strcmpi(options.Projection,'tau-k')
    tkbackground(h,options);
else
    uvbackground(h,options);
end
end
function uvbackground(h,options)
fw='normal';
%Plot background structure for U,V plot
    set(0, 'currentfigure', h);
    axis equal
    if (~options.Contour&&~options.MaxSource)&&numel(options.Probability)>0&&~(iscell(options.MT)&&all(cellfun(@iscell,options.MT)))
        patch([0,0,1.5,1.5,4/3],[-1,-1.5,-1.5,1/3,1/3],ones(1,5),'EdgeColor','w','FaceColor','w');
        patch([0,0,1.5,1.5,4/3],[1,1.5,1.5,1/3,1/3],ones(1,5),'EdgeColor','w','FaceColor','w');
        patch([0,0,-1.5,-1.5,-4/3],[1,1.5,1.5,-1/3,-1/3],ones(1,5),'EdgeColor','w','FaceColor','w');
        patch([0,0,-1.5,-1.5,-4/3],[-1,-1.5,-1.5,-1/3,-1/3],ones(1,5),'EdgeColor','w','FaceColor','w');    
    end
    s=0.5;
    line([0,0],[-1,1],[0.1,0.1],'Color','k','LineWidth',s*options.LineWidth);
    line([-1,1],[0,0],[0.1,0.1],'Color','k','LineWidth',s*options.LineWidth);
    line([0,4/3],[-1,1/3],[0.1,0.1],'Color','k','LineWidth',options.LineWidth);
    line([0,-4/3],[-1,-1/3],[0.1,0.1],'Color','k','LineWidth',options.LineWidth);
    line([-4/3,0],[-1/3,1],[0.1,0.1],'Color','k','LineWidth',options.LineWidth);
    line([0,4/3],[1,1/3],[0.1,0.1],'Color','k','LineWidth',options.LineWidth);
    grey=[0.8,0.8,0.8];
    n=5;
    if options.InteriorLines
        for i=1:n-1
            %Diagonal line
            line([-4/3,4/3],[-1/3,1/3],[0.1,0.1],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            T=i*(1/(n));
            k=i*(1/(n));
            %second/fourth quadrant have k=v
            line([0,(1-(k))],[-k,-k],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            line([0,-(1-(k))],[k,k],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            line([0,-(T)],[1,0],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            line([0,(T)],[-1,0],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            %first quadrant
            %A
            line([0,4*T/(4-T)],[1,T/(4-T)],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            if i<=floor(n/4)
                line([0,4*k/(1-2*k)],[k,k/(1-2*k)],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            else
                line([0,2*(1-k)/(1+k)],[k,2*k/(1+k)],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            end
            %B
            line([T,T/(1-0.25*T)],[0,T/(4-T)],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            %third quadrant
            %A
            line([0,-4*T/(4-T)],[-1,-T/(4-T)],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            if i<=floor(n/4)
                line([0,-4*k/(1-2*k)],[-k,-k/(1-2*k)],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            else
                line([0,-2*(1-k)/(1+k)],[-k,-2*k/(1+k)],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            end
            %B
            line([-T,-T/(1-0.25*T)],[0,-T/(4-T)],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
        end
        % extra k lines in B part of first and third quadrant
        line([0.5,1.125],[0.125,0.125],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
        line([-0.5,-1.125],[-0.125,-0.125],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
    end
    if options.AxisLabel
    text(0.05,1.2,0.01,'v','HorizontalAlignment','Left','VerticalAlignment','Bottom','FontSize',options.FontSize);
    text(1.25,-0.1,0.01,'u','HorizontalAlignment','Left','FontSize',options.FontSize);
    end
    if options.Text
        text(-1.2,0,0.01,'(-1,0)','FontSize',options.FontSize);
        text(1.02,-0.04,0.01,'(1,0)','FontSize',options.FontSize);
        text(0.05,-1.02,0.01,'(0,-1)','HorizontalAlignment','Left','VerticalAlignment','Top','FontSize',options.FontSize);
        text(0.05,1.02,0.01,'(0,1)','HorizontalAlignment','Left','VerticalAlignment','Bottom','FontSize',options.FontSize);
        text(0.2,0.07,0.01,'V =U / 4','HorizontalAlignment','Center','VerticalAlignment','Bottom','Rotation',14,'FontSize',options.FontSize);
        text(0.51,-0.51,0.01,'V=U-1','HorizontalAlignment','Center','VerticalAlignment','Top','Rotation',45,'FontSize',options.FontSize);
        text(0.51,0.78,0.01,'V=1- U/2','HorizontalAlignment','Center','VerticalAlignment','Bottom','Rotation',-26.5,'FontSize',options.FontSize);
        text(-0.51,-0.78,0.01,'V=-1- U/2','HorizontalAlignment','Center','VerticalAlignment','Top','Rotation',-26.5,'FontSize',options.FontSize);
        text(-0.51,0.51,0.01,'V=U+1','HorizontalAlignment','Center','VerticalAlignment','Bottom','Rotation',45,'FontSize',options.FontSize);
        text(1.4,1/3,0.01,'(^4/_3,^1/_3)','HorizontalAlignment','Left','FontSize',options.FontSize);
        text(-1.4,-1/3,0.01,'(-^4/_3,-^1/_3)','HorizontalAlignment','Right','FontSize',options.FontSize);
    end
    if strcmp(char(class(options.MT)),'char')
        if strcmp(options.MT,'none')
            options.TypeLabel=true;
        end
    end
    if options.TypeLabel
            grey2=[0.6,0.6,0.6];
            grey2=[0,0,0];
            text(-1.05,0,0.5,'CLVD ','HorizontalAlignment','Right','VerticalAlignment','Middle','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
            text(1.05,0,0.5,' CLVD','HorizontalAlignment','Left','VerticalAlignment','Middle','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
            text(0,1.05,0.5,'Explosion','HorizontalAlignment','Center','VerticalAlignment','Bottom','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
            text(0,-1.05,0.5,'Implosion','HorizontalAlignment','Center','VerticalAlignment','Top','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
            text(0,0,0.5,'DC','HorizontalAlignment','Center','VerticalAlignment','Bottom','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
            text(-0.4444,0.5556,0.5,'TC_+','HorizontalAlignment','Right','VerticalAlignment','Bottom','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
            text(0.4444,-0.5556,0.5,'TC_-','HorizontalAlignment','Left','VerticalAlignment','Top','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
    end
%     grey=[0.4,0.4,0.4];
%     text(0,-1.01,'Implosive','Color',grey,'FontSize',options.FontSize,'HorizontalAlignment','Center','VerticalAlignment','Top')
%     text(0,1.01,'Explosive','Color',grey,'FontSize',options.FontSize,'HorizontalAlignment','Center','VerticalAlignment','Bottom')
    axis([-1.5,1.5,-1.5,1.5])
    ylim([-1.1,1.1])
    set(h,'Color','w');
    axis off
    grid off
end
function tkbackground(h,options)
fw='normal';
%Plot tau,k background structure
    set(0, 'currentfigure', h);
    if (~options.Contour&&~options.MaxSource)&&numel(options.Probability)>0&&~(iscell(options.MT)&&all(cellfun(@iscell,options.MT)))
        patch([0,0,1.5,1.5,1],[-1,-1.5,-1.5,0,0],ones(1,5),'EdgeColor','w','FaceColor','w');
        patch([0,0,1.5,1.5,1],[1,1.5,1.5,0,0],ones(1,5),'EdgeColor','w','FaceColor','w');
        patch([0,0,-1.5,-1.5,-1],[1,1.5,1.5,0,0],ones(1,5),'EdgeColor','w','FaceColor','w');
        patch([0,0,-1.5,-1.5,-1],[-1,-1.5,-1.5,0,0],ones(1,5),'EdgeColor','w','FaceColor','w');    
    end
    s=0.5;
    grey=[0.8,0.8,0.8];
    line([0,1],[-1,0],[0.1,0.1],'Color','k','LineWidth',options.LineWidth);
    line([0,1],[1,0],[0.1,0.1],'Color','k','LineWidth',options.LineWidth);
    line([0,-1],[1,0],[0.1,0.1],'Color','k','LineWidth',options.LineWidth);
    line([0,-1],[-1,0],[0.1,0.1],'Color','k','LineWidth',options.LineWidth);
    line([0,0],[-1,1],[0.1,0.1],'Color','k','LineWidth',s*options.LineWidth);
    line([-1,1],[0,0],[0.1,0.1],'Color','k','LineWidth',s*options.LineWidth);
    if options.InteriorLines
        n=5;
        d=1/n;
        for i=1:n-1
            line([0,i*d],[-1,0],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            line([0,i*-d],[-1,0],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            line([0,i*d],[1,0],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
            line([0,i*-d],[1,0],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
        end
        line([-0.8,0.8],[-0.2,0.2],[0.1,0.1],'Color',grey,'LineStyle','- -','LineWidth',s*options.LineWidth);
    end
    if options.AxisLabel
        text(0.05,1,0.01,'\tau','HorizontalAlignment','Left','VerticalAlignment','Bottom','FontSize',options.FontSize);
    text(0.96,-0.1,0.01,'k','HorizontalAlignment','Left','FontSize',options.FontSize);
   
    end
    if options.Text
        text(-1.02,0,'(-1,0)','HorizontalAlignment','Right','FontSize',options.FontSize);
        text(1.02,0,'(1,0)','FontSize',options.FontSize);
        text(0,-1.02,0,'(0,-1)','HorizontalAlignment','Center','VerticalAlignment','Top','FontSize',options.FontSize);
        text(0,1.02,0,'(0,1)','HorizontalAlignment','Center','VerticalAlignment','Bottom','FontSize',options.FontSize);
        
        text(0.49,-0.015,'\tau \rightarrow','FontSize',options.FontSize); 
        text(0.01,0.51,'k','FontSize',options.FontSize);
        text(0.01,0.57,'\uparrow','FontSize',options.FontSize);
        text(0.2,0.07,'k =\tau /4','HorizontalAlignment','Center','VerticalAlignment','Bottom','Rotation',14,'FontSize',options.FontSize);
        text(0.51,-0.51,'k=-1+\tau (T=1)','HorizontalAlignment','Center','VerticalAlignment','Top','Rotation',45,'FontSize',options.FontSize);
        text(0.51,0.51,'k=1- \tau (T=1)','HorizontalAlignment','Center','VerticalAlignment','Bottom','Rotation',-45,'FontSize',options.FontSize);
        text(-0.51,-0.51,'k=-1- \tau (T=-1)','HorizontalAlignment','Center','VerticalAlignment','Top','Rotation',-45,'FontSize',options.FontSize);
        text(-0.51,0.51,'k=1+\tau (T=-1)','HorizontalAlignment','Center','VerticalAlignment','Bottom','Rotation',45,'FontSize',options.FontSize);
    end
    if strcmp(char(class(options.MT)),'char')
        if strcmp(options.MT,'none')
            options.TypeLabel=true;
        end
    end
    if options.TypeLabel
        grey2=[0.6,0.6,0.6];
        grey2=[0,0,0];
        text(-1.0,0,0.5,'CLVD ','HorizontalAlignment','Right','VerticalAlignment','Middle','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
        text(1.0,0,0.5,' CLVD','HorizontalAlignment','Left','VerticalAlignment','Middle','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
        text(0,1.05,0.5,'Explosion','HorizontalAlignment','Center','VerticalAlignment','Bottom','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
        text(0,-1.05,0.5,'Implosion','HorizontalAlignment','Center','VerticalAlignment','Top','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
        text(0,0,0.5,'DC','HorizontalAlignment','Center','VerticalAlignment','Bottom','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
        text(-0.4444,0.5556,0.5,'TC_+','HorizontalAlignment','Right','VerticalAlignment','Bottom','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
        text(0.4444,-0.5556,0.5,'TC_-','HorizontalAlignment','Left','VerticalAlignment','Top','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
    end
    axis square
    axis([-1.2,1.2,-1.2,1.2])
    set(h,'Color','w');
    axis off
    grid off
end
function FaultPlaneBackground(MT,h,options)
set(0, 'currentfigure', h);
[x,y,z]=sphere(options.Resolution);
[X,Y,Z]=options.ProjFn(x,y,z,options);
hold on;
C=reshape(kron(ones(size(X)),[0.9,0.9,0.9]),size(X,1),size(X,2),3);
surf(X,Y,Z,C,'EdgeColor','None');
%colormap([0.9 0.9 0.9]);
% plot a circle round the center
hold off
GenericBackground(MT,h,options)
end
function HXBackground(MT,h,options)
fw='normal';
set(0, 'currentfigure', h);
box on
set(gcf,'Color','w')
axis square
set(gca,'fontsize',options.FontSize);
n=10;
hold on
for i=1:n
    d=[0:0.01:1];
    plot3(d,0*d+i/n,0*d,'LineStyle','- -','Color',[0.8,0.8,0.8],'LineWidth',options.LineWidth);
    plot3(0*d+i/n,d,0*d,'LineStyle','- -','Color',[0.8,0.8,0.8],'LineWidth',options.LineWidth);
end
if options.TypeLabel
        grey2=[0.6,0.6,0.6];
        grey2=[0,0,0];
        [x,y]=MT2HX([2,-1,-1,0,0,0]);
        text(x,y,1.0,'CLVD ','HorizontalAlignment','Right','VerticalAlignment','Middle','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
        [x,y]=MT2HX([1,1,-2,0,0,0]);
        text(x,y,1.0,' CLVD','HorizontalAlignment','Left','VerticalAlignment','Middle','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
        [x,y]=MT2HX([1,1,1,0,0,0]);
        text(x,y,1.0,'Explosion','HorizontalAlignment','Center','VerticalAlignment','Bottom','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
        [x,y]=MT2HX([-1,-1,-1,0,0,0]);
        text(x,y,1.0,'Implosion','HorizontalAlignment','Center','VerticalAlignment','Top','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
        text(0.5,0.5,1.0,'DC','HorizontalAlignment','Center','VerticalAlignment','Middle','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
        [x,y]=MT2HX([3,1,1,0,0,0]);
        text(x,y,1.0,'TC_+','HorizontalAlignment','Right','VerticalAlignment','Bottom','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
        [x,y]=MT2HX([-1,-1,-3,0,0,0]);
        text(x,y,1.0,'TC_-','HorizontalAlignment','Left','VerticalAlignment','Top','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
        if options.AxisLabel
            text(0.5,-0.03,'\eta','HorizontalAlignment','Center','VerticalAlignment','Top','FontSize',options.FontSize)
            text(-0.15,0.5,'\xi','HorizontalAlignment','Right','VerticalAlignment','Middle','FontSize',options.FontSize)
        end
elseif options.AxisLabel
    
    xlabel('\eta')
    ylabel('\xi')
    
end
    hold off;
    set(gca,'view',[0 90])
    xlim([0,1]);
    ylim([0,1]);
    set(gca,'XTick',[])
    set(gca,'YTick',[])
% GenericBackground(MT,h,options)
end
function LuneBackground(MT,h,options)
axis normal;
axis equal;
axis off;
grid off;

if strcmpi(options.Dimension,'3d')
    hold on;
    [x,y,z]=GetGreatCircle([0,0,1],[cos(pi/6),sin(pi/6),0]);
    [x,y,z]=options.ProjFn(x,y,z,options);
    ind=abs(atan2(y,x))<pi/2;
    x=x(ind);
    y=y(ind);
    z=z(ind);
    plot3(x,y,z,'k','LineWidth',0.5*options.LineWidth);
    [x,y,z]=GetGreatCircle([0,0,1],[cos(pi/6),-sin(pi/6),0]);
    [x,y,z]=options.ProjFn(x,y,z,options);
    ind=abs(atan2(y,x))<pi/2;
    x=x(ind);
    y=y(ind);
    z=z(ind);
    plot3(x,y,z,'k','LineWidth',0.5*options.LineWidth);
    [x,y,z]=sphere(options.Resolution*5);
    [X,Y,Z]=options.ProjFn(x,y,z,options);
    C=reshape(kron(ones(size(X)),[0.95,0.95,0.95]),size(X,1),size(X,2),3);
    ind=abs(atan2(Y,X))<pi/6;
    C(ind)=nan;
    X(ind)=nan;
    Y(ind)=nan;
    Z(ind)=nan;
    a=0.99;
    surf(a*X,a*Y,a*Z,C,'EdgeColor','None');
    [x,y,z]=sphere(options.Resolution);
    [X,Y,Z]=options.ProjFn(x,y,z,options);
    C=reshape(kron(ones(size(X)),[0.95,0.95,0.95]),size(X,1),size(X,2),3);
    surf(a*X,a*Y,0*Z,C,'FaceColor',[0.5,0.5,0.5],'EdgeColor','None')
    theta=acos(Z);
    phi=-pi/6;
    r=kron(ones(size(X,1),1),linspace(0,1,size(X,2)));
    X=r.*sin(theta).*cos(phi);
    Y=r.*sin(theta).*sin(phi);
    Z=r.*cos(theta);
    surf(a*X,a*Y,a*Z,'FaceColor',[0.7,0.7,0.7],'EdgeColor','None')
    phi=pi/6;
    X=r.*sin(theta).*cos(phi);
    Y=r.*sin(theta).*sin(phi);
    Z=r.*cos(theta);
    surf(a*X,a*Y,a*Z,'FaceColor',[0.7,0.7,0.7],'EdgeColor','None')
    set(gca,'view',[90 0])
    n=10;
    for i=1:n
        [x,y,z]=GetSmallCircle([0,0,1],i*pi/(n+2),[pi/6,11*pi/6]);
        [x,y,z]=options.ProjFn(x,y,z,options);
        plot3(x,y,z,'k','LineStyle','-','Color','k','LineWidth',0.5*options.LineWidth);
        [x,y,z]=GetSmallCircle([0,0,1],i*pi/(n+2),[-pi/6,pi/6]);
        [x,y,z]=options.ProjFn(x,y,z,options);
        plot3(x,y,z,'k','LineStyle','-','Color',[1,0.3,0],'LineWidth',options.LineWidth);
    end
    for i=1:5
        theta=-3*pi/18+i*pi/18;
        [x,y,z]=GetGreatCircle([0,0,1],[cos(theta),-sin(theta),0],2);
        [x,y,z]=options.ProjFn(x,y,z,options);
        plot3(x,y,z,'LineStyle','-','Color',[1,0.3,0],'LineWidth',options.LineWidth);
    end   
    for i=1:31
        theta=2*pi/18+i*pi/18;
        [x,y,z]=GetGreatCircle([0,0,1],[cos(theta),-sin(theta),0],2);
        [x,y,z]=options.ProjFn(x,y,z,options);
        plot3(x,y,z,'LineStyle','-','Color','k','LineWidth',0.5*options.LineWidth);
    end   
    view(115,10)
    %light('position',[45,30,30])
    %light('position',[45,30,30])
    hold off
end
if strcmpi(options.Dimension,'2d')
    ylim([-sqrt(2),sqrt(2)]);
    xlim([-0.55,0.55])
    hold on;
    [x,y,z]=GetGreatCircle([0,1,0],[sin(pi/6),0,cos(pi/6)]);
    [x,y,z]=options.ProjFn(x,y,z,options);
    plot3(x,y,z+1,'k','LineWidth',options.LineWidth);
    [x,y,z]=GetGreatCircle([0,1,0],[-sin(pi/6),0,cos(pi/6)]);
    [x,y,z]=options.ProjFn(x,y,z,options);
    plot3(x,y,z+1,'k','LineWidth',options.LineWidth);
    s=0.5;
    if options.InteriorLines
        for i=1:5
            theta=-3*pi/18+i*pi/18;
            [x,y,z]=GetGreatCircle([0,1,0],[sin(theta),0,cos(theta)]);
            [x,y,z]=options.ProjFn(x,y,z,options);
            plot3(x,y,z,'LineStyle','- -','Color',[0.8,0.8,0.8],'LineWidth',s*options.LineWidth);
        end    
        n=10;
        for i=1:n
        [x,y,z]=GetSmallCircle([0,1,0],i*pi/(n+2),-pi/2+[-pi/6,pi/6]);
        [x,y,z]=options.ProjFn(x,y,z,options);
        plot3(x,y,z,'k','LineStyle','- -','Color',[0.8,0.8,0.8],'LineWidth',s*options.LineWidth);
        end
    end
    [x,~,~]=LuneCoords([2,-1,-1],options);
    line([-x,x],[0,0],'Color','k','LineWidth',s*options.LineWidth)
    [~,y,~]=LuneCoords([1,1,1],options);
    line([0,0],[-y,y],'Color','k','LineWidth',s*options.LineWidth)
    
    if iscell(options.MT)
        if strcmp(options.MT,'none')
            options.TypeLabel=true;
        end
    end
%     axis equal
    if options.TypeLabel
            grey2=[0.6,0.6,0.6];
            grey2=[0,0,0];
            fw='normal';
            [x,y,~]=LuneCoords([2,-1,-1],options);
            text(x,y,0.5,'CLVD ','HorizontalAlignment','Right','VerticalAlignment','Middle','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
            [x,y,~]=LuneCoords([1,1,-2],options);
            text(x,y,0.5,' CLVD','HorizontalAlignment','Left','VerticalAlignment','Middle','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
            [x,y,~]=LuneCoords([1,1,1],options);
            text(x,y,0.5,'Explosion','HorizontalAlignment','Center','VerticalAlignment','Bottom','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
            [x,y,~]=LuneCoords([-1,-1,-1],options);
            text(x,y,0.5,'Implosion','HorizontalAlignment','Center','VerticalAlignment','Top','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
            text(0,0,0.5,'DC','HorizontalAlignment','Center','VerticalAlignment','Bottom','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
            [x,y,~]=LuneCoords([3,1,1],options);
            text(x-0.1,y-0.2,0.5,'TC_+','HorizontalAlignment','Right','VerticalAlignment','Bottom','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
            [x,y,~]=LuneCoords([-1,-1,-3],options);
            text(x+0.1,y+0.1,0.5,'TC_-','HorizontalAlignment','Left','VerticalAlignment','Top','FontSize',options.FontSize,'Color',grey2,'FontWeight',fw);
%             ylim([-1.7,1.7])
            
    end
    hold off;
    set(gca,'view',[0 90])
end
if options.PanelMode
    freezeColors
end
if options.PT
    PT(MT,h,options)
end
set(h,'Color','w');
end
function [X,Y,Z]=LuneCoords(E,options)
[g,d]=E2GD(E);
b=pi/2-d;
x=cos(g).*sin(b);
y=sin(g).*sin(b);
z=cos(b);
options.Lower=false;
if strcmpi(options.Dimension,'2d')
    R=[0,1,0;0,0,1;-1,0,0];
    v=R*[x';y';z'];
    x=v(1,:);
    y=v(2,:);
    z=v(3,:);
end
[X,Y,Z]=options.ProjFn(x,y,z,options);
X=X;
Y=Y;
Z=Z;
end