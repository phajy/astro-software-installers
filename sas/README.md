# XMM SAS

There is a [Docker for SAS](https://www.cosmos.esa.int/web/xmm-newton/sas-installation-docker4sas) web page.

From the [SAS download](https://www.cosmos.esa.int/web/xmm-newton/sas-download) web page download [sas_20_0_docker.tar.gz](https://www.cosmos.esa.int/web/xmm-newton/download-form?p_p_id=com_liferay_iframe_web_portlet_IFramePortlet_INSTANCE_gUKOliY2Q7Oa&_com_liferay_iframe_web_portlet_IFramePortlet_INSTANCE_gUKOliY2Q7Oa_iframe_f=8).

Then unzip the file and load it into Docker.

```
gunzip sas_20_0_docker.tar.gz
docker load -i sas_20_0_docker.tar
```

## CCF

You will also need an up-to-dave set of valid calibration files.

```
rsync -v -a --delete --delete-after --force --include='*.CCF' --exclude='*/' sasdev-xmm.esac.esa.int::XMM_VALID_CCF /path/to/your/CCF
```

## Using XMM SAS

Download the [`run_sasdocker`](https://sasdev-xmm.esac.esa.int/pub/sas/20.0.0/docker4sas/scripts/run_sasdocker) script. Further instructions are available on the [Docker for SAS](https://www.cosmos.esa.int/web/xmm-newton/sas-installation-docker4sas) web page.
