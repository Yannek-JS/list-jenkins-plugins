import hudson.model.*
jenkins = Hudson.instance
jenkins.instance.pluginManager.plugins.each {
    println it.getShortName() + ',' + it.getVersion() + ',"' + it.getDisplayName() + '"'
}
