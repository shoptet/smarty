{capture name='_smarty_debug' assign=debug_output}
<div class="smartyDebugConsoleTrigger">Smarty debug console</div>
<div class="smartyDebugConsole">
{literal}
    <style type="text/css">

    .smartyDebugConsoleTrigger,
    .smartyDebugConsole,
    .smartyDebugConsole p,
    .smartyDebugConsole h1,
    .smartyDebugConsole h2,
    .smartyDebugConsole h3 {
        margin: 0;
        padding: 0;
        font-family: Consolas, Courier New, Courier, Lucida Sans Typewriter, Lucida Typewriter, monospace;
        font-weight: normal;
        text-transform: none;
        color: #fff;
    }
    .smartyDebugConsoleTrigger,
    .smartyDebugConsole,
    .smartyDebugConsole p {
        font-size: 12px;
    }
    .smartyDebugConsole h1,
    .smartyDebugConsole h2,
    .smartyDebugConsole h3 {
        margin-bottom: 1em;
    }
    .smartyDebugConsole p {
        margin-bottom: .5em;
    }
    .smartyDebugConsole h1 {
        font-size: 18px;
        color: #0dc00d;
    }
    .smartyDebugConsole h2 {
        font-size: 16px;
    }
    .smartyDebugConsole h3 {
        font-size: 14px;
    }
    .smartyDebugConsole table {
        width: 100%;
    }
    .smartyDebugConsole tr.odd {
        background-color: rgba(0,0,0,.15);
    }
    .smartyDebugConsole th,
    .smartyDebugConsole td {
        padding: 5px;
        border: 1px solid #fff;
    }
    .smartyDebugConsole th[colspan] {
        background-color: rgba(0,0,0,.35);
        color: #0dc00d;
    }
    .smartyDebugConsole th[colspan] span {
        font-size: 14px;
    }
    .smartyDebugConsole th {
        text-align: left;
        color: #b5951c;
    }
    .smartyDebugConsoleTrigger,
    .smartyDebugConsole {
        position: fixed;
        left: 0;
        background-color: rgba(44,0,30,.95);
    }
    .smartyDebugConsoleTrigger {
        z-index: 999999;
        bottom: 0;
        padding: 0 1em;
        border: 1px solid rgba(0,0,0,.15);
        line-height: 30px;
        cursor: pointer;
    }
    .smartyDebugConsoleTrigger:hover,
    .smartyDebugConsoleTrigger.active {
        color: #0dc00d;
    }
    .smartyDebugConsoleTrigger.trigger2 {
        bottom: 29px;
    }
    .smartyDebugConsoleTrigger.trigger3 {
        bottom: 58px;
    }
    .smartyDebugConsoleTrigger.trigger4 {
        bottom: 87px;
    }
    .smartyDebugConsole {
        display: none;
        z-index: 999998;
        left: 0;
        bottom: 0;
        width: 100%;
        height: 100%;
        padding: 10px 10px 87px;
        overflow: auto;
        line-height: 1.4;
        text-align: left;
    }
    .smartyDebugConsole.active {
        display: block;
    }
    .smartyDebugConsole .gray {
        color: #aea79f;
    }
    .smartyDebugConsoleTime {
        color: #b5951c;
    }
    .smartyDebugConsoleFilename {
        display: block;
    }
    .smartyDebugConsoleFilename a {
        color: #fff;
    }
    @media (min-width: 1024px) {
        .smartyDebugConsole {
            width: 80%;
        }
    }
    @media (min-width: 1200px) {
        .smartyDebugConsole {
            width: 50%;
        }
    }
</style>
<script>
    $(function() {
        var i = 1;
        $('.smartyDebugConsoleTrigger').each(function() {
            $(this).text('Smarty debug console ' + i);
            $(this).addClass('trigger' + i);
            i++;
        });
        $('.smartyDebugConsoleTrigger').unbind().bind('click', function() {
            $('.smartyDebugConsole').not($(this).next('.smartyDebugConsole')).removeClass('active');
            $(this).next('.smartyDebugConsole').toggleClass('active');
            $('.smartyDebugConsoleTrigger').not($(this)).removeClass('active');
            $(this).toggleClass('active');
        });
    });
</script>
{/literal}

<h1>Smarty Debug Console</h1>
{if isset($template_name)}
<p class="gray">
    Template name:
    {$template_name|debug_print_var nofilter}{else}Total Time {$execution_time|string_format:"%.5f"}
    <br />
</p>
{/if}

{if !empty($template_data)}
<h2>Included templates &amp; config files (load time in seconds)</h2>

{foreach $template_data as $template}
  <span class="smartyDebugConsoleFilename"><a href="editor://open/?file={$template.name}">{$template.name}</a></span>
  <p class="gray">
      compile <span class="smartyDebugConsoleTime">{$template['compile_time']|string_format:"%.5f"}</span>
      / render <span class="smartyDebugConsoleTime">{$template['render_time']|string_format:"%.5f"}</span>
      / cache <span class="smartyDebugConsoleTime">{$template['cache_time']|string_format:"%.5f"}</span>
  </p>
{/foreach}
{/if}

{if $grouped_assigned_vars}
<h2>Assigned template variables</h2>
{foreach from=$grouped_assigned_vars key=key item=assigned_vars}
<table id="table_assigned_vars">
    <tr>
        <th colspan="3"><span>Scope:</span> {$key}</th>
    </tr>
    {foreach $assigned_vars as $vars}
       <tr class="{if $vars@iteration % 2 eq 0}odd{else}even{/if}">
        <th>${$vars@key|escape:'html'}</th>
        <td>{dump($vars->value)}</td>
       </tr>
    {/foreach}
</table>
{/foreach}
{/if}

{if $config_vars}
<h2>assigned config file variables (outer template scope)</h2>

<table id="table_config_vars">
    {foreach $config_vars as $vars}
       <tr class="{if $vars@iteration % 2 eq 0}odd{else}even{/if}">
       <th>{$vars@key|escape:'html'}</th>
       <td>{dump($vars->value)}</td></tr>
    {/foreach}

</table>
{/if}
</div>
{/capture}
{$debug_output}

