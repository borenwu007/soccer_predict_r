<template>
  <a-layout id="components-layout-demo-side" style="min-height: 100vh">
    <a-layout-sider collapsible v-model="collapsed">
      <div class="logo" />
      <a-menu theme="dark" mode="inline">
        <a-menu-item key="1">
          <a-icon type="pie-chart" />
          <span>Option 1</span>
        </a-menu-item>

        <a-menu-item key="2">
          <a-icon type="desktop" />
          <span>Option 2</span>
        </a-menu-item>

        <!-- <a-sub-menu key="sub1">
          <span slot="title">
            <a-icon type="user" />
            <span>User</span>
          </span>
          <a-menu-item key="3">Tom</a-menu-item>
          <a-menu-item key="4">Bill</a-menu-item>
          <a-menu-item key="5">Alex</a-menu-item>
        </a-sub-menu>
        
        <a-sub-menu key="sub2">
          <span slot="title">
            <a-icon type="team" />
            <span>Team</span>
          </span>
          <a-menu-item key="6">Team 1</a-menu-item>
          <a-menu-item key="8">Team 2</a-menu-item>
        </a-sub-menu>-->

        <!-- <a-menu-item key="9">
          <a-icon type="file" />
          <span>File</span>
        </a-menu-item>-->
      </a-menu>
    </a-layout-sider>

    <a-layout>
      <a-layout-header style="background: #fff; padding: 0" />

      <a-layout-content style="margin: 0 16px">
        <a-breadcrumb style="margin: 16px 0">
          <a-breadcrumb-item>User</a-breadcrumb-item>
          <a-breadcrumb-item>Bill</a-breadcrumb-item>
        </a-breadcrumb>

        <a-row>
          <a-col :span="8">
            <div id="leagure_team" style="margin: 0 16px">
              <a-input-group>
                <a-input
                  placeholder="input leagure"
                  allowClear
                  @change="setLeagure"
                  :value="leagure"
                  style="margin-bottom: 16px"
                />

                <a-input
                  placeholder="input home team"
                  allowClear
                  @change="setHome"
                  :value="team_h"
                  style="margin-bottom: 16px"
                />

                <a-input
                  placeholder="input away team"
                  allowClear
                  @change="setAway"
                  :value="team_a"
                  style="margin-bottom: 16px"
                />

                <a-button type="primary" @click="sendPredict">Primary</a-button>
              </a-input-group>
            </div>
          </a-col>

          <a-col :span="16">
            <div id="show_data" style="margin: 0 16px">
              <a-progress
                type="circle"
                :percent="home"
                :format="percent => `${percent} Home ${team_h}`"
              />
              <a-progress type="circle" :percent="draw" :format="percent => `${percent} Draw`" />
              <a-progress
                type="circle"
                :percent="away"
                :format="percent => `${percent} Away ${team_a}`"
              />
            </div>
          </a-col>
        </a-row>
      </a-layout-content>

      <a-layout-footer style="text-align: center">Ant Design ©2018 Created by Ant UED</a-layout-footer>
    </a-layout>
  </a-layout>
</template>

<script>
export default {
  data() {
    return {
      collapsed: false,
      leagure: "",
      team_h: "",
      team_a: "",
      home: 0.0,
      draw: 0.0,
      away: 0.0
    };
  },

  methods: {
    setLeagure(e) {
      const { value } = e.target;
      this.leagure = value;
    },

    setHome(e) {
      const { value } = e.target;
      this.team_h = value;
    },

    setAway(e) {
      const { value } = e.target;
      this.team_a = value;
    },

    sendPredict() {
      let that = this;
      let url = "http://127.0.0.1:5000/api/predict";
      this.$http
        .post(url, {
          leagure: this.leagure,
          team_h: this.team_h,
          team_a: this.team_a
        })
        .then(function(response) {
          let result = response.data.result;

          let home_result = result[0];
          let draw_result = result[1];
          let away_result = result[2];
          
          that.home = (parseFloat(home_result.exp_result) * 100).toFixed(2);
          that.draw = (parseFloat(draw_result.exp_result) * 100).toFixed(2);
          that.away = (parseFloat(away_result.exp_result) * 100).toFixed(2);
        })
        .catch(function(error) {
          console.log(error);
        });
    }
  }
};
</script>

<style>
</style>