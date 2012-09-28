# providers/app.rb
#
# java_app provider wraps basic functionality for deploying Java based (Maven) application

include JavaApplication

def get_artefact
	if new_resource.source == :local
		location = "/var/10xlab"
	end

	spec = application_spec(location)

	build_artefact(spec)

	spec
end

def build_artefact(spec)
	# FIXME hardcoded root"
	lab_home = "/var/10xlab"

	target_artefact = "target/#{spec[:artifactId]}.#{spec[:packaging]}"
	artefact_location = ::File.join(lab_home, target_artefact)

	unless ::File.exists?(artefact_location)
		command = %Q{cd /var/10xlab && mvn package}

		batch = Chef::Resource::Script::Bash.new "build maven artefact", run_context
		batch.code command
		batch.run_action(:run)
	end
end

def deploy_app(spec)
	command = "cp /var/10xlab/target/#{spec[:artifactId]}.#{spec[:packaging]} #{new_resource.destination}"

	batch = Chef::Resource::Script::Bash.new "copy artefact", run_context
	batch.code command
	batch.run_action(:run)
end

action :deploy do
	Chef::Log.info '--- app_deploy'
	Chef::Log.info new_resource.inspect

	spec = get_artefact
	deploy_app(spec)
end