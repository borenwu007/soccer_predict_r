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
              <a-select defaultValue="选择联赛" style="margin-bottom: 16px" @change="setLeagure">
                <a-select-option value="England_a">英超</a-select-option>
                <a-select-option value="England_b">英冠</a-select-option>
                <a-select-option value="Italy_a">意甲</a-select-option>
                <a-select-option value="Span_a">西甲</a-select-option>
                <a-select-option value="Germany_a">德甲</a-select-option>
                <a-select-option value="Germany_b">德乙</a-select-option>
                <a-select-option value="France_a">法甲</a-select-option>
                <a-select-option value="Nether_a">荷甲</a-select-option>
                <a-select-option value="Port_a">葡甲</a-select-option>
              </a-select>

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

        <a-row style="margin: 10px 16px">
          <a-table bordered :dataSource="dataSource" :columns="columns">
            <!-- <template slot="name" slot-scope="text, record">
              <editable-cell :text="text" @change="onCellChange(record.key, 'name', $event)" />
            </template>-->
            <template slot="operation" slot-scope="text, record">
              <a-popconfirm
                v-if="dataSource.length"
                title="Sure to delete?"
                @confirm="() => onDelete(record.key)"
              >
                <a href="javascript:;">Delete</a>
              </a-popconfirm>
              <a-divider type="vertical" />
              <a href="javascript:;" @click="onViewRecord(record.key)">View</a>
            </template>
          </a-table>
        </a-row>
      </a-layout-content>

      <a-layout-footer style="text-align: center">Ant Design ©2018 Created by Ant UED</a-layout-footer>
    </a-layout>
  </a-layout>
</template>

<script>
import EditableCell from "./EditableCell";

export default {
  components: {
    EditableCell
  },
  data() {
    return {
      collapsed: false,
      leagure: "",
      team_h: "",
      team_a: "",
      home: 0.0,
      draw: 0.0,
      away: 0.0,
      count:0,
      dataSource: [
        
      ],
      columns: [
        {
          title: "Home",
          dataIndex: "Home",
          width: "20%",
          scopedSlots: { customRender: "Home" }
        },
        {
          title: "Away",
          dataIndex: "Away",
          width: "0%",
          scopedSlots: { customRender: "Away" }
        },
        {
          title: "win",
          dataIndex: "win"
        },
        {
          title: "draw",
          dataIndex: "draw"
        },
        {
          title: "lose",
          dataIndex: "lose"
        },
        {
          title: "home_g",
          dataIndex: "home_g"
        },
        {
          title: "away_g",
          dataIndex: "away_g"
        },
        {
          title: "operation",
          dataIndex: "operation",
          scopedSlots: { customRender: "operation" }
        }
      ]
    };
  },

  methods: {
    setLeagure(value) {
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

    onCellChange(key, dataIndex, value) {
      const dataSource = [...this.dataSource];
      const target = dataSource.find(item => item.key === key);
      if (target) {
        target[dataIndex] = value;
        this.dataSource = dataSource;
      }
    },
    onDelete(key) {
      const dataSource = [...this.dataSource];
      this.dataSource = dataSource.filter(item => item.key !== key);
    },

    onViewRecord(key) {
      const dataSource = [...this.dataSource];
      const target = dataSource.find(item => item.key === key);
      if (target) {
        this.home = parseFloat((target.win * 100).toFixed(2))
        this.draw = parseFloat((target.draw * 100).toFixed(2))
        this.away = parseFloat((target.lose * 100).toFixed(2))
      }
    },

    handleAdd() {
      const { count, dataSource } = this;
      const newData = {
        key: count,
        name: `Edward King ${count}`,
        age: 32,
        address: `London, Park Lane no. ${count}`
      };
      this.dataSource = [...dataSource, newData];
      this.count = count + 1;
    },

    sendPredict() {
      const { count, dataSource } = this;
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

          that.home = parseFloat((home_result.exp_result * 100).toFixed(2));
          that.draw = parseFloat((draw_result.exp_result * 100).toFixed(2));
          that.away = parseFloat((away_result.exp_result * 100).toFixed(2));

          let home_g = parseFloat(home_result.exp_goals).toFixed(2)
          let away_g = parseFloat(away_result.exp_goals).toFixed(2)

          const newData = {
            key: count,
            Home: home_result.team_name,
            Away: away_result.team_name,
            win: home_result.exp_result,
            draw: draw_result.exp_result,
            lose: away_result.exp_result,
            home_g: home_g,
            away_g: away_g
          };

          that.dataSource = [...dataSource, newData];
          that.count = count + 1;
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