function [] = FinalProject()

% --------------------------Assigning my global variable
    global plotting;
    
% --------------------------Getting the plot onto the figure
    plotting.fig = figure('numbertitle','off','name','Graph it Yourself Calculator');
    plotting.fig = plot(0,0);
    plotting.graphTitle = uicontrol('style','text','units','normalized','position', [.6 .91 .09 .095], 'string','title','HorizontalAlignment','right');
    plotting.xAxisTitle = uicontrol('style','text','units','normalized','position', [.6 .34 .09 .095], 'string','x-axis','HorizontalAlignment','right');
    plotting.yAxisTitle = uicontrol('style','text','units','normalized','position', [.3 .65 .09 .095], 'string','y-axis','HorizontalAlignment','right');
    pos = [0.45 0.475 .5 .43];
    subplot('Position',pos);
        
%--------------------------Placing and naming the edit box for the x values
    plotting.xVal = uicontrol('style','edit','units','normalized','position', [.33 .23 .09 .095],'callback', {@call});
    plotting.xValMessage = uicontrol('style','text','units','normalized','position', [.32 .13 .09 .095],'string','X Values','HorizontalAlignment','right');
    
%--------------------------Placing and naming the edit box for the y values
    plotting.yVal = uicontrol('style','edit','units','normalized','position', [.33 .09 .09 .095],'callback', {@call});
    plotting.yValMessage = uicontrol('style','text','units','normalized','position', [.32 0 .09 .095],'string','Y Values','HorizontalAlignment','right');
    
%--------------------------Adding the pushbutton to reset the graph
    plotting.pushbutton = uicontrol('style','pushbutton','units','normalized','position', [.91 0 .09 .095],'string','reset','callback', {@push});
    
%--------------------------Adding the Radiobuttons
    plotting.bg = uibuttongroup('Visible','on','position',[0 0 .15 1],'SelectionChangedFcn', {@bselection});
        
        r1 = uicontrol(plotting.bg,'style','radiobutton','String','Red','position',[10 350 100 30], 'HandleVisibility','on');
        r2 = uicontrol(plotting.bg,'style','radiobutton','String','Blue','position',[10 250 100 30], 'HandleVisibility','on');
        r3 = uicontrol(plotting.bg,'style','radiobutton','String','Black','position',[10 150 100 30], 'HandleVisibility','on');

    plotting.bg2 = uibuttongroup('Visible','on','position',[.15 0 .15 1],'SelectionChangedFcn', {@bg2selection});
    
        radio1 = uicontrol(plotting.bg2,'style','radiobutton','String','Dashed','position',[10 350 100 30], 'HandleVisibility','on');
        radio2 = uicontrol(plotting.bg2,'style','radiobutton','String','Solid','position',[10 250 100 30], 'HandleVisibility','on');
        radio3 = uicontrol(plotting.bg2,'style','radiobutton','String','Stars','position',[10 150 100 30], 'HandleVisibility','on');
        
%--------------------------Adding x-lims and y-lims
    plotting.xLim = uicontrol('style','edit','units','normalized','position', [.43 .23 .09 .095],'callback', {@Lim});
    plotting.xLimMessage = uicontrol('style','text','units','normalized','position', [.41 .13 .09 .095],'string','X Lim','HorizontalAlignment','right');
    
    plotting.yLim = uicontrol('style','edit','units','normalized','position', [.43 .09 .09 .095],'callback', {@Lim});
    plotting.yLimMessage = uicontrol('style','text','units','normalized','position', [.41 0 .09 .095],'string','Y Lim','HorizontalAlignment','right');
    
%--------------------------Plot Title
    plotting.title = uicontrol('style','edit','units','normalized','position', [.53 .23 .09 .095], 'callback', {@changeTitle});
    plotting.titleMessage = uicontrol('style','text','units','normalized','position', [.52 .13 .09 .095], 'string','Plot Title','HorizontalAlignment','right');
    function [] = changeTitle(source, event)
        
        plotting.graphTitle.String = plotting.title.String;
        
    end
%--------------------------Axes titles
    plotting.xAxisTitleNew = uicontrol('style','edit','units','normalized','position', [.63 .23 .09 .095], 'callback', {@noMoreNames});
    plotting.xAxisTitleNewMessage = uicontrol('style','text','units','normalized','position', [.61 .13 .09 .095], 'string','X-axis name','HorizontalAlignment','right');
    function [] = noMoreNames(source,event)
        
        plotting.xAxisTitle.String = plotting.xAxisTitleNew.String;
        
    end

    plotting.yAxisTitleNew = uicontrol('style','edit','units','normalized','position', [.73 .23 .09 .095], 'callback', {@noMoreNames2});
    plotting.yAxisTitleNewMessage = uicontrol('style','text','units','normalized','position', [.71 .13 .09 .095], 'string','Y-axis name','HorizontalAlignment','right');
    function [] = noMoreNames2(source,event)
        
        plotting.yAxisTitle.String = plotting.yAxisTitleNew.String;
        
    end
end

%--------------------------Now we want to plot our x and y vales
function [] = call (~,~)

    global plotting;
    if isempty(plotting.xVal.String) || isempty(plotting.yVal.String)
        msgbox('Place values in both the X Values and Y Values boxes','guiPlottingError','error','modal')
        return
        
    end

    xValues = str2num(plotting.xVal.String);
    yValues = str2num(plotting.yVal.String);

    if length(xValues) ~= length(yValues)
        msgbox('Place the same number of coordinates in each box','guiPlottingError','error','modal')
        return
        
    end
    
    plotting.myPlot = plot(xValues,yValues);
    
end

%--------------------------Callback function for resetting the graph
function [] = push(~,~)

    global plotting
    plotting.fig = plot(0,0);
    pos = [0.45 0.475 .5 .43];
    subplot('Position',pos);
    
    plotting.graphTitle = uicontrol('style','text','units','normalized','position', [.6 .91 .09 .095], 'string','title','HorizontalAlignment','right');
    plotting.xAxisTitle = uicontrol('style','text','units','normalized','position', [.6 .34 .09 .095], 'string','x-axis','HorizontalAlignment','right');
    plotting.yAxisTitle = uicontrol('style','text','units','normalized','position', [.3 .65 .09 .095], 'string','y-axis','HorizontalAlignment','right');

end

%--------------------------Setting up for the button clicking
function [] = bselection(~,~)

    global plotting
    buttonColor = plotting.bg.SelectedObject.String;
    buttonSpecies = plotting.bg2.SelectedObject.String;
    graph(buttonColor, buttonSpecies);

end

%--------------------------Setting up for the button clicking
function [] = bg2selection(~,~)

    global plotting
    
    xValues = str2num(plotting.xVal.String);
    yValues = str2num(plotting.yVal.String);
    
    buttonSpecies = plotting.bg2.SelectedObject.String;
    graph(buttonColor, buttonSpecies)
end

%--------------------------This is what should run when the buttons click
function [] = graph(buttonColor, buttonSpecies)

    global plotting
    
    buttonColor = plotting.bg.SelectedObject.String;
    buttonSpecies = plotting.bg2.SelectedObject.String;
    
    xValues = str2num(plotting.xVal.String);
    yValues = str2num(plotting.yVal.String);
    
    if strcmp(buttonColor, 'Red') && strcmp(buttonSpecies, 'Dashed')
        plotting.myPlot = plot(xValues,yValues, '--r');
    elseif strcmp(buttonColor, 'Red') && strcmp(buttonSpecies, 'Solid')
        plotting.myPlot = plot(xValues,yValues, '-r');
    elseif strcmp(buttonColor, 'Red') && strcmp(buttonSpecies, 'Stars')
        plotting.myPlot = plot(xValues,yValues, '*r');
    elseif strcmp(buttonColor, 'Blue') && strcmp(buttonSpecies, 'Dashed')
        plotting.myPlot = plot(xValues,yValues, '--b');
    elseif strcmp(buttonColor, 'Blue') && strcmp(buttonSpecies, 'Solid')
        plotting.myPlot = plot(xValues,yValues, '-b');
    elseif strcmp(buttonColor, 'Blue') && strcmp(buttonSpecies, 'Stars')
        plotting.myPlot = plot(xValues,yValues, '*b');
    elseif strcmp(buttonColor, 'Black') && strcmp(buttonSpecies, 'Dashed')
        plotting.myPlot = plot(xValues,yValues, '--k');
    elseif strcmp(buttonColor, 'Black') && strcmp(buttonSpecies, 'Solid')
        plotting.myPlot = plot(xValues,yValues, '-k');
    else strcmp(buttonColor, 'Black') && strcmp(buttonSpecies, 'Stars');
        plotting.myPlot = plot(xValues,yValues, '*k');
    end

end

%--------------------------Changing the limits
function [] = Lim(~,~)

    global plotting
    
    xValues = str2num(plotting.xVal.String);
    yValues = str2num(plotting.yVal.String);
    
    plotting.myPlot = plot(xValues,yValues);
    
    xlim = (plotting.xLim.String);
    ylim = (plotting.yLim.String);

end