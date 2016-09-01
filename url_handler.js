<script>
// This solution is based on one from
// http://stackoverflow.com/questions/25306519/shiny-saving-url-state-subpages-and-tabs
Shiny.addCustomMessageHandler('setURL',
    function(data) {
        window.history.pushState('object or string', 'Title', '/?tags=' + data.tags);
    }
);
</script>
