FROM sgclark/trusty-qt59
# KF5
RUN wget https://raw.githubusercontent.com/appimage-packages/appimage-template/master/docker/qt59/kf5/kf5.sh
RUN chown -R root:root kf5.sh
RUN /bin/bash -x kf5.sh
RUN rm kf5.sh
