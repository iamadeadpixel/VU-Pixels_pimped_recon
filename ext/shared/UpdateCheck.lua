require('__shared/version')
-- Object in mod.json for Reason: upgrade - patch - bugfix - new release - stable release - test
-- or anything else you want to announce.
-- if u want to use this, use the mod.json i am using, it contains the   "Reason": "whatever it is",  entry.

function getCurrentVersion()
    options = HttpOptions({}, 10);
    options.verifyCertificate = false; --ignore cert for wine users
    res = Net:GetHTTP("https://raw.githubusercontent.com/spatieman/VU-Pixels_pimped_recon/main/mod.json", options);
    if res.status ~= 200 then
        return null;
    end
    json = json.decode(res.body);
    return json.Version,json.Reason;
--    return json.Version;
end


function checkVersion()
    if getCurrentVersion() ~= localModVersion then
	print("**********************************************************************************************");
        print("** VU-Pixels_pimped_recon seems to be out of date! Please visit https://github.com/spatieman/VU-Pixels_pimped_recon **" );
	print('Changed Version on github is ('..json.Version..') - Local version:('..localModVersion..') - Reason for update: ('..json.Reason..')')
	print("**********************************************************************************************");
	else
	print("************************************************************************");
	print("************** VU-Pixels_pimped_recon seems to be up2date **************");
	print('Version on github is ('..json.Version..') - Local version:('..localModVersion..')...')
	print("************************************************************************");
    end
end

checkVersion();


