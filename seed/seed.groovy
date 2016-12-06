#!/usr/bin/env groovy

import org.yaml.snakeyaml.Yaml
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.security.Provider.Service
import com.google.common.io.ByteStreams

def apps = new Yaml().load(new FileReader(new File("${WORKSPACE}/seed/applications.yaml")))

apps.each { name, config ->
  multibranchPipelineJob("pipeline-${name}-appimage") {
    branchSources {
        git {
            remote(config.repo)
            credentialsId('ScarlettGatelyClark')
        }
    }
    orphanedItemStrategy {
        discardOldItems {
            numToKeep(2)
        }
    }
}
}
