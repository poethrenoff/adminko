{foreach from=$menu_tree item=menu_item}
<div style="margin-left: {$menu_item._depth * 20}px">
	<a{if $menu_item._selected} style="font-weight: bold"{/if} href="{$menu_item.menu_url}">{$menu_item.menu_title|escape}</a>
</div>
{/foreach}
