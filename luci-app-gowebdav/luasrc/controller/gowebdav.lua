module("luci.controller.gowebdav", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/gowebdav") then
		return
	end
	local page
	page = entry({"admin", "services", "gowebdav"}, cbi("gowebdav"), _("GoWebDav"), 100)
	page.dependent = true
	entry({"admin", "services","gowebdav","status"},call("act_status")).leaf=true
end

function act_status()
	local e={}
	e.running=luci.sys.call("pgrep gowebdav >/dev/null")==0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end